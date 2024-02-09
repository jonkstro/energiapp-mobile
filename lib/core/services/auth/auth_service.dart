// interface que vai dizer como vai funcionar a autenticação
import 'package:energiapp/core/models/user_model.dart';
import 'package:energiapp/core/services/auth/auth_firebase_service.dart';

abstract class AuthService {
  // getter para obter informações sobre o usuário atual
  UserModel? get currentUser;
  // stream que fornece alterações no usuário atual ao longo do tempo.
  // pode ser que tenha ou não um user, se tiver deslogado vai ser null.
  Stream<UserModel?> get userChanges;

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
  factory AuthService() {
    // se quiser usar outra implementação, basta mudar o Firebase para alguma outra
    return AuthFirebaseService();
    // return AuthMockService();
  }
}

/// Comentários adicionais explicativos
/**
Um Factory Method é um padrão de design que fornece uma interface para criar objetos em uma superclasse, mas permite que as subclasses alterem o tipo de objetos que serão criados. Ele é um padrão de criação, que lida com o processo de instanciação de objetos.

No código acima:

factory AuthService() {
  return AuthFirebaseService();
}

factory é uma palavra-chave no Dart que indica que um método na classe é uma fábrica de objetos. No caso do padrão Factory Method, a ideia é que a própria classe seja responsável por criar instâncias de suas subclasses ou de classes relacionadas.

Neste exemplo, o método AuthService é uma fábrica para criar uma instância da classe AuthFirebaseService. Isso significa que, ao chamar AuthService(), você obtém uma instância de AuthFirebaseService sem precisar saber os detalhes específicos de implementação.

O benefício desse padrão é que, se no futuro você decidir mudar a implementação do serviço de autenticação para algo diferente de AuthFirebaseService, você só precisa modificar a fábrica na classe AuthService e o resto do código que usa AuthService permanece inalterado. Isso ajuda a encapsular a lógica de criação de objetos e torna o código mais flexível e fácil de manter.

 */
