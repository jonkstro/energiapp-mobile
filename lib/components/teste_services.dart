import 'package:energiapp/components/error_snackbar.dart';
import 'package:energiapp/core/models/user_model.dart';
import 'package:energiapp/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';

class TesteServices extends StatelessWidget {
  const TesteServices({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user =
        UserModel(id: '2', name: 'teste2', email: 'email2@teste.com');
    const String pass = '123456789';

    Future<void> logar() async {
      try {
        await AuthService().login(
          user.email,
          pass,
        );
      } catch (error) {
        print('error: $error');
        ErrorSnackbar.show(context, error);
      }
    }

    Future<void> registrar() async {
      try {
        // ...
        await AuthService().signUp(user.email, pass, user.name);
        print(AuthService().currentUser);
      } catch (error) {
        print('error: $error');
        ErrorSnackbar.show(context, error);
      }
    }

    print('Ola services');
    return Column(
      children: [
        const Text('Teste Services'),
        ElevatedButton(
          child: const Text('Logar'),
          onPressed: () => logar(),
        ),
        ElevatedButton(
          child: const Text('Registrar'),
          onPressed: () => registrar(),
        ),
      ],
    );
  }
}
