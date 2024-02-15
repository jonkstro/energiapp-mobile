import 'package:energiapp/components/auth_form_widget.dart';
import 'package:energiapp/components/background_widget.dart';
import 'package:energiapp/components/error_snackbar.dart';
import 'package:energiapp/components/logo_container_widget.dart';
import 'package:energiapp/core/models/auth_form_data.dart';
import 'package:energiapp/core/services/auth/auth_state_service.dart';
import 'package:energiapp/pages/email_validation_page.dart';
import 'package:energiapp/pages/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Vai executar essa função passando o formulário lá no authForm
  Future<void> _handleSubmit(
      AuthFormData formData, GlobalKey<FormState> formKey) async {
    if (mounted) {
      setState(() => formData.isLoading = true);
    }
    try {
      if (formData.isLogin) {
        // login
        await AuthStateService()
            .login(
          formData.email,
          formData.password,
          formData.continueLogged,
        )
            .then(
          (value) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        );
      } else {
        // signup
        await AuthStateService()
            .signUp(
          formData.email,
          formData.password,
          formData.name,
        )
            .then(
          (value) {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => const EmailValidationPage(),
              ),
            )
                .then((_) {
              // Este código será executado quando a página EmailValidationPage for fechada
              // Pode chamar formKey.currentState.reset() aqui
              setState(() {
                formData.continueLogged = false;
                formKey.currentState?.reset();
              });
            });
          },
        );
      }
    } catch (error) {
      if (mounted) {
        ErrorSnackbar.show(context, error);
      }
      if (error.toString().contains('E-mail não verificado')) {
        if (mounted) {
          Navigator.of(context)
              .push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => EmailValidationPage(
                email: formData.email,
              ),
            ),
          )
              .then((_) {
            // Este código será executado quando a página EmailValidationPage for fechada
            // Pode chamar formKey.currentState.reset() aqui
            setState(() {
              formData.continueLogged = false;
              formKey.currentState?.reset();
            });
          });
        }
      }
    } finally {
      if (mounted) {
        setState(() => formData.isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BackgroundWidget(
          child: AuthFormWidget(onSubmit: _handleSubmit),
        ),
      ),
    );
  }
}
