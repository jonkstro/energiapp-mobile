import 'package:energiapp/components/error_snackbar.dart';
import 'package:energiapp/core/services/auth/auth_state_firebase_service.dart';
import 'package:energiapp/utils/validators/auth_form_validator.dart';
import 'package:flutter/material.dart';

class ForgotPassFormWidget extends StatefulWidget {
  const ForgotPassFormWidget({super.key});

  @override
  State<ForgotPassFormWidget> createState() => _ForgotPassFormWidgetState();
}

class _ForgotPassFormWidgetState extends State<ForgotPassFormWidget> {
  bool _isLoading = false;
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (mounted) {
      setState(() => _isLoading = true);
    }
    try {
      final isValid =
          AuthFormValidator().emailValidator(_emailController.text.trim());
      if (isValid != null) {
        return ErrorSnackbar.show(context, isValid);
      }
      await AuthStateFirebaseService()
          .sendPasswordResetEmail(_emailController.text)
          .then((value) {
        return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Email Enviado',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              content: Text(
                'Enviamos um email com link de mudança de senha para o email ${_emailController.text}',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Ok'),
                ),
              ],
            );
          },
        );
      });
    } catch (error) {
      if (mounted) {
        return ErrorSnackbar.show(context, error);
      }
    } finally {
      if (mounted) {
        setState(() {
          _emailController.clear();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Text(
              'Esqueceu a senha?',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.left,
            ),
            Text(
              'Preencha o email que cadastrou a sua conta abaixo. \nEnviaremos um link para recuperar sua senha',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                  )
                : Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                      child: Text(
                        'Reccuperar Senha',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      onPressed: () {
                        _submitForm();
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
