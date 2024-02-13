import 'package:energiapp/core/models/user_model.dart';
import 'package:energiapp/core/services/auth/auth_state_firebase_service.dart';

abstract class AuthStateService {
  // getter para obter informações sobre o usuário atual
  UserModel? get currentUser;
  Future<UserModel?> get loggedUserData;

  Future<void> signUp(
    String email,
    String password,
    String name,
    // add outros campos do formulário, se precisar
  );

  Future<void> login(
    String email,
    String password,
    bool continueLogged,
    // add outros campos do formulário, se precisar (ex.: continuar logado?)
  );

  Future<void> logout();

  // Factory method que retorna uma instância da implementação concreta
  // do AuthService, neste caso, AuthFirebaseService.
  factory AuthStateService() {
    // se quiser usar outra implementação, basta mudar o Firebase para alguma outra
    return AuthStateFirebaseService();
    // return AuthMockService();
  }
}
