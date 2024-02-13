// definir estado de login ou registrar
enum AuthMode {
  login,
  signUp,
}

// classe responsável pela interação com o componente AuthForm
class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  bool continueLogged = false;
  bool hidePassword = true;
  bool hideConfirmPassword = true;
  // add outros campos do formulário, se necessário

  // iniciar sempre na tela de login
  AuthMode _authMode = AuthMode.login;

  bool get isLogin {
    return _authMode == AuthMode.login;
  }

  bool get isSignUp {
    return _authMode == AuthMode.signUp;
  }

  void toggleAuthMode() {
    _authMode = isLogin ? AuthMode.signUp : AuthMode.login;
  }
}
