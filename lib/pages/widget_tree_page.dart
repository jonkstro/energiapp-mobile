import 'package:energiapp/core/models/user_model.dart';
import 'package:energiapp/core/services/auth/auth_state_service.dart';
import 'package:energiapp/pages/auth_page.dart';
import 'package:energiapp/pages/email_validation_page.dart';
import 'package:energiapp/pages/home_page.dart';
import 'package:energiapp/pages/splash_screen.dart';
import 'package:energiapp/utils/constants/firebase_constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class WidgetTreePage extends StatefulWidget {
  const WidgetTreePage({super.key});

  @override
  State<WidgetTreePage> createState() => _WidgetTreeStatePage();
}

class _WidgetTreeStatePage extends State<WidgetTreePage> {
  Future<void> _init(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();

    kIsWeb // essas opções são para não dar erro no web
        ? await Firebase.initializeApp(
            options: FirebaseConstants.firebaseConfig,
          )
        : await Firebase.initializeApp(); // Inicializa o Firebase
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Aguardar o Firebase iniciar
      future: _init(context),
      builder: (context, initSnapshot) {
        if (initSnapshot.connectionState == ConnectionState.done) {
          return FutureBuilder(
            future: AuthStateService().loggedUserData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // Se não vier nada, tem que fazer login
                return const AuthPage();
              }
              final UserModel user = snapshot.data!;
              // Se o user não tiver ativo, vai para página de email validation
              // if (!user.isActive!) return EmailValidationPage();
              if (user.expiresAt!.isBefore(DateTime.now())) {
                return const AuthPage();
              }
              return const HomePage();
            },
          );
        }
        // Aguardando dados
        else {
          return const SplashScreen();
        }
      },
    );
  }
}
