import 'package:energiapp/components/error_snackbar.dart';
import 'package:energiapp/core/models/user_model.dart';
import 'package:energiapp/core/services/auth/auth_state_service.dart';
import 'package:flutter/material.dart';

class TesteServices extends StatelessWidget {
  const TesteServices({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthStateService();

    final UserModel user =
        // UserModel(id: '06', name: 'teste06', email: 'email06@teste.com');
        UserModel(id: 'j1', name: 'jonas', email: 'jonascastro.dev@gmail.com');
    const String pass = '123456789';

    Future<void> logar() async {
      try {
        await auth.login(user.email, pass, true);
        // await AuthService().login(user.email, pass, false);
        // // await AuthService().login(user.email, pass, true);
      } catch (error) {
        print('error: $error');
        ErrorSnackbar.show(context, error);
      }
    }

    Future<void> registrar() async {
      try {
        // ...
        await auth.signUp(user.email, pass, user.name);
        print('authenticated currentUser');
        print(await auth.loggedUserData);
      } catch (error) {
        print('error: $error');
        ErrorSnackbar.show(context, error);
      }
    }

    Future<void> sair() async {
      try {
        // ...
        await auth.logout();
        print('authenticated currentUser');
        print(await auth.loggedUserData);
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
        ElevatedButton(
          child: const Text('Sair'),
          onPressed: () => sair(),
        ),
      ],
    );
  }
}
