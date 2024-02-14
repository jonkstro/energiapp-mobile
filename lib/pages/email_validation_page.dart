import 'package:energiapp/components/error_snackbar.dart';
import 'package:energiapp/core/models/user_model.dart';
import 'package:energiapp/core/services/auth/auth_state_firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailValidationPage extends StatefulWidget {
  final String? email;
  const EmailValidationPage({super.key, this.email});

  @override
  State<EmailValidationPage> createState() => _EmailValidationPageState();
}

class _EmailValidationPageState extends State<EmailValidationPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    AuthStateFirebaseService auth =
        Provider.of<AuthStateFirebaseService>(context);
    UserModel? currentUser = auth.currentUser;

    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              backgroundColor: Colors.transparent,
              floating: false, // A AppBar não será flutuante
              pinned:
                  false, // A AppBar não será fixada no topo ao rolar para baixo
            ),
            SliverToBoxAdapter(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Quase lá!',
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    RichText(
                      text: TextSpan(
                        text: 'Enviamos um email de confirmação para o email ',
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                            text: ' ${widget.email ?? currentUser?.email}.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Precisamos verificar seu email antes de liberarmos o acesso, a fim de garantir uma maior segurança na plataforma.',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    Image.asset('assets/images/email.png'),
                    const SizedBox(height: 20),
                    Text(
                      'Ainda não recebeu seu email de verificação?',
                      style: Theme.of(context).textTheme.bodySmall,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    _isLoading
                        ? CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onPrimary,
                          )
                        : TextButton.icon(
                            icon: Icon(
                              Icons.email,
                              color:
                                  Theme.of(context).textTheme.bodyMedium!.color,
                            ),
                            label: Text(
                              'Reenviar email de verificação',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            onPressed: () async {
                              // só vem pra cá quando de fato tiver current user após chamada
                              // do signup ou login

                              if (mounted) {
                                setState(() => _isLoading = true);
                              }
                              try {
                                await auth.verifyEmail(
                                    widget.email ?? auth.currentUser!.email);
                              } catch (error) {
                                if (mounted) {
                                  ErrorSnackbar.show(context, error);
                                }
                              }
                              if (mounted) {
                                setState(() => _isLoading = false);
                              }
                            },
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
