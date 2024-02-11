import 'package:energiapp/core/services/auth/auth_state_firebase_service.dart';
import 'package:energiapp/pages/auth_page.dart';
import 'package:energiapp/pages/email_validation_page.dart';
import 'package:energiapp/pages/home_page.dart';
import 'package:energiapp/pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class WidgetTreePage extends StatefulWidget {
  const WidgetTreePage({super.key});

  @override
  State<WidgetTreePage> createState() => _WidgetTreeStatePage();
}

class _WidgetTreeStatePage extends State<WidgetTreePage> {
  Future<void> _init(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(); // Inicializa o Firebase
    await Future.delayed(const Duration(seconds: 1)); // Dar um charme
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Aguardar o Firebase iniciar
      future: _init(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Aguardando dados
          return const SplashScreen();
        } else {
          return FutureBuilder(
            future: AuthStateFirebaseService().loggedUserData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const AuthPage();
              }
              if (!snapshot.data!.isActive!) return const EmailValidationPage();
              if (snapshot.data!.expiresAt!.isBefore(DateTime.now())) {
                return const AuthPage();
              }
              return const HomePage();
            },
          );
        }
      },
    );
  }
}
