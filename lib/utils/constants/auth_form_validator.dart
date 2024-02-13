class AuthFormValidator {
  String? nameValidator(String name) {
    if (name.trim().isEmpty || name.trim().length < 4) {
      return 'Informe um nome válido';
    }
    return null;
  }

  String? emailValidator(String email) {
    // TODO:
    // 1 - Validar por emails válidos 'gmail', 'hotmail', etc...
    // 2 - Verificar caracteres especiais proibidos
    if (email.trim().isEmpty ||
        !email.contains('@') ||
        !email.contains('.com')) {
      return 'Informe um email válido';
    }
    return null;
  }

  String? passwordValidator(String password) {
    List<String> errors = [];
    // Verificar se a senha é vazia ou tem menos de 5 caracteres
    if (password.isEmpty || password.length < 5) {
      errors.add('Preencha ao menos 5 caracteres');
    }

    // Verificar se a senha contém pelo menos uma letra maiúscula
    if (!password.contains(RegExp(r'[A-Z]'))) {
      errors.add('Preencha ao menos uma letra maiúscula');
    }

    // Verificar se a senha contém pelo menos uma letra minúscula
    if (!password.contains(RegExp(r'[a-z]'))) {
      errors.add('Preencha ao menos uma letra minúscula');
    }

    // Verificar se a senha contém pelo menos um número
    if (!password.contains(RegExp(r'[0-9]'))) {
      errors.add('Preencha ao menos um número');
    }

    // Verificar se a senha contém pelo menos um caractere especial
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      errors.add('Preencha ao menos um caractere especial');
    }
    // Se houver erros, retorna a mensagem concatenada; caso contrário, retorna null
    return errors.isEmpty ? null : errors.join('\n');
  }

  String? confirmPasswordValidator(String password, String newPassword) {
    if (password != newPassword) {
      return 'As senhas diferem uma da outra';
    }
    return null;
  }
}
