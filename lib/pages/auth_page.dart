import 'package:energiapp/components/auth_form_widget.dart';
import 'package:energiapp/components/error_snackbar.dart';
import 'package:energiapp/components/logo_container_widget.dart';
import 'package:energiapp/core/models/auth_form_data.dart';
import 'package:energiapp/core/services/auth/auth_state_firebase_service.dart';
import 'package:energiapp/core/services/auth/auth_state_service.dart';
import 'package:energiapp/pages/email_validation_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Vai executar essa função passando o formulário lá no authForm
  Future<void> _handleSubmit(AuthFormData formData) async {
    if (mounted) {
      setState(() => formData.isLoading = true);
    }
    try {
      if (formData.isLogin) {
        // login
        await AuthStateService().login(
          formData.email,
          formData.password,
          formData.continueLogged,
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
            Navigator.of(context).push(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => const EmailValidationPage(),
              ),
            );
          },
        );
      }
    } catch (error) {
      if (mounted) {
        ErrorSnackbar.show(context, error);
      }
      if (error.toString().contains('E-mail não verificado')) {
        print('testado');
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => EmailValidationPage(
                email: formData.email,
              ),
            ),
          );
        }
      }
      print('error: $error');
    } finally {
      if (mounted) {
        setState(() => formData.isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthStateFirebaseService>(context);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const LogoContainerWidget(),
              Center(
                child: Container(
                  margin: EdgeInsets.only(
                    top: size.height >= 400
                        ? size.height * 0.4
                        : size.height * 0.5,
                  ),
                  alignment: Alignment.center,
                  constraints: const BoxConstraints(
                    maxWidth: 600,
                  ),
                  child: AuthFormWidget(onSubmit: _handleSubmit),
                ),
              ),
              // // Quando tiver carregando a página vai ficar "pensando"
              // if (_isLoading)
              //   Container(
              //     height: size.height,
              //     decoration:
              //         const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              //     child: Center(
              //       child: CircularProgressIndicator(
              //         color: Theme.of(context).colorScheme.onPrimary,
              //       ),
              //     ),
              //   )
            ],
          ),
        ),
      ),
    );
  }
}
