import 'package:energiapp/core/services/auth/auth_service.dart';
import 'package:energiapp/pages/auth_page.dart';
import 'package:energiapp/pages/email_validation_page.dart';
import 'package:energiapp/pages/home_page.dart';
import 'package:energiapp/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthOrAppPage extends StatefulWidget {
  const AuthOrAppPage({super.key});

  @override
  State<AuthOrAppPage> createState() => _AuthOrAppPageState();
}

class _AuthOrAppPageState extends State<AuthOrAppPage> {
  Future<void> _init(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // Inicializa o Firebase
    await Future.delayed(const Duration(seconds: 1)); // Dar um charme
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        } else {
          return StreamBuilder(
            stream: AuthService().userChanges,
            builder: (context, snapshot) {
              // se a stream tiver dados = fez login ou registrou
              if (snapshot.hasData) {
                // se o dado da stream tiver ativo = verificou email
                if (snapshot.data!.isActive!) {
                  return const HomePage();
                }
                return const EmailValidationPage();
              }
              // se a stream não tiver dados = fez logout
              return const AuthPage();
            },
          );
        }
      },
    );
  }
}
