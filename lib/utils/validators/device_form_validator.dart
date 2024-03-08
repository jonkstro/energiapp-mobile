class DeviceFormValidator {
  String? macValidator(String mac) {
    if (mac.trim().isEmpty || mac.trim().length < 17) {
      return 'Informe o ID correto';
    }
    return null;
  }

  String? nameValidator(String name) {
    if (name.trim().isEmpty || name.trim().length < 4) {
      return 'Informe um nome válido';
    }
    return null;
  }
}
