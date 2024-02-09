import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:energiapp/core/models/user_model.dart';
import 'package:energiapp/core/services/auth/auth_service.dart';
import 'package:energiapp/utils/constants/firebase_constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

// classe que vai implementar a interface de autenticação
class AuthFirebaseService implements AuthService {
  // Variável estática para armazenar o usuário atual
  static UserModel? _currentUser;

  // Stream que fornece alterações no usuário atual ao longo do tempo
  static final _userStream = Stream<UserModel?>.multi((control) async {
    // Obtém as alterações no estado de autenticação do Firebase
    final authChanges = FirebaseAuth.instance.authStateChanges();
    // Aguarda as alterações e atualiza o usuário atual
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toUserModel(user);
      // Adiciona o usuário atual ao stream de alterações
      control.add(_currentUser);

      /// TODO: Verificar se consegue logar pelo sharedPreferences
    }
  });

  @override
  UserModel? get currentUser => _currentUser;

  @override
  Stream<UserModel?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    final auth = FirebaseAuth.instance;
    // Efetua o login com e-mail e senha
    final userCredential = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Verifica se o e-mail do usuário foi verificado
    if (userCredential.user?.emailVerified ?? false) {
      // TODO: Adicionar lógica para salvar a preferência de login automático
      // no SharedPreferences aqui, se necessário.

      // O login foi bem-sucedido
      print('Login successful!');
    } else {
      // Se o e-mail não foi verificado, você pode optar por lidar com isso
      // de acordo com os requisitos do seu aplicativo.
      print('E-mail not verified. Please verify your e-mail address.');
      await logout();
    }
  }

  @override
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signUp(String email, String password, String name) async {
    final auth = FirebaseAuth.instance;
    UserCredential credential = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) {
      //1 - atualizar os dados do user
      await credential.user!.updateDisplayName(name);
      // 2 - fazer o login - nossa lógica não vai logar após registrar
      // await login(email, password);
      // 3 - salvar os dados do user no Firestore
      _currentUser = _toUserModel(credential.user!, isCreated: true);
      await _saveUserDataOnDatabase(_currentUser!);
      // Deslogar, caso ele faça o login sozinho
      // await logout();
    }
  }

  // Salvar as informações de user pertinentes ao app no Firestore ou RealtimeDB
  Future<void> _saveUserDataOnDatabase(UserModel user) async {
    // Instanciar o Firestore
    final store = FirebaseFirestore.instance;
    // Definir o ID do documento que vai ser criado na collection de users
    const String userPath = FirebaseConstants.userCollectionName;
    final docRef = store.collection(userPath).doc(user.id);

    // Salvar no Firestore
    return docRef.set({
      'name': user.name,
      'email': user.email,
      // estou garantindo que vou ter um createdAt!
      'createdAt': user.createdAt!.toIso8601String(),
      'updatedAt': user.updatedAt?.toIso8601String(),
    });
  }

  // Converte um objeto User do Firebase em um UserModel personalizado
  static _toUserModel(
    User user, {
    bool? isCreated,
    bool? isUpdated,
    String? name,
  }) {
    return UserModel(
      // TODO: Verificar se o nome não tá vindo no user, se tiver apago o name
      id: user.uid,
      name: name ??
          user.displayName ??
          user.email!.split('@')[0] ??
          "DefaultName",
      email: user.email!,
      createdAt: isCreated ?? false ? DateTime.now() : null,
      updatedAt: isUpdated ?? false ? DateTime.now() : null,
    );
  }
}
