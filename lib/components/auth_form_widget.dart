import 'package:energiapp/core/models/auth_form_data.dart';
import 'package:energiapp/pages/forgot_pass_page.dart';
import 'package:energiapp/utils/constants/auth_form_validator.dart';
import 'package:flutter/material.dart';

class AuthFormWidget extends StatefulWidget {
  final void Function(AuthFormData, GlobalKey<FormState>) onSubmit;
  const AuthFormWidget({super.key, required this.onSubmit});

  @override
  State<AuthFormWidget> createState() => _AuthFormWidgetState();
}

class _AuthFormWidgetState extends State<AuthFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) return;
    // Chamar a função que vai ser passada por parametro pelo authPage
    widget.onSubmit(_formData, _formKey);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formData.isLogin ? 'Logar' : 'Registrar',
                      style: Theme.of(context).textTheme.headlineLarge,
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            _formData.isLogin
                                ? 'Não tem conta ainda?'
                                : 'Já tem uma conta?',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ),
                        TextButton(
                          child: Text(
                            _formData.isLogin ? 'Cadastrar' : 'Fazer Login',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          onPressed: () {
                            setState(() {
                              _formData.toggleAuthMode();
                              _formData.continueLogged = false;
                            });
                            _formKey.currentState?.reset();
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Visibility(
                visible: _formData.isSignUp,
                child: TextFormField(
                  onChanged: (value) => _formData.name = value,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      errorStyle:
                          Theme.of(context).inputDecorationTheme.errorStyle,
                      labelText: 'Nome Completo'),
                  validator: _formData.isLogin
                      ? null
                      : (value) {
                          final String name = value ?? '';
                          return AuthFormValidator().nameValidator(name);
                        },
                ),
              ),
              Visibility(
                visible: _formData.isSignUp,
                child: const SizedBox(height: 20),
              ),
              TextFormField(
                onChanged: (value) => _formData.email = value,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  // errorStyle: TextStyle(color: Colors.green),
                  errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                  labelText: 'Email',
                ),
                validator: _formData.isLogin
                    ? null
                    : (value) {
                        final String email = value ?? '';
                        return AuthFormValidator().emailValidator(email);
                      },
              ),
              const SizedBox(height: 20),
              TextFormField(
                onChanged: (value) => _formData.password = value,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
                  labelText: 'Senha',
                  suffixIcon: IconButton(
                    icon: Icon(_formData.hidePassword
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _formData.hidePassword = !_formData.hidePassword;
                      });
                    },
                  ),
                ),
                obscureText: _formData.hidePassword,
                validator: _formData.isLogin
                    ? null
                    : (value) {
                        final String password = value ?? '';
                        return AuthFormValidator().passwordValidator(password);
                      },
              ),
              const SizedBox(height: 20),
              Visibility(
                visible: _formData.isSignUp,
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    errorStyle:
                        Theme.of(context).inputDecorationTheme.errorStyle,
                    labelText: 'Repita a sua senha',
                    suffixIcon: IconButton(
                      icon: Icon(_formData.hideConfirmPassword
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _formData.hideConfirmPassword =
                              !_formData.hideConfirmPassword;
                        });
                      },
                    ),
                  ),
                  obscureText: _formData.hideConfirmPassword,
                  validator: _formData.isLogin
                      ? null
                      : (value) {
                          final String confirmPassword = value ?? '';
                          return AuthFormValidator().confirmPasswordValidator(
                            _formData.password,
                            confirmPassword,
                          );
                        },
                ),
              ),
              Visibility(
                visible: _formData.isSignUp,
                child: const SizedBox(height: 20),
              ),
              // ...
              Visibility(
                visible: _formData.isLogin,
                child: GestureDetector(
                  onTap: () {
                    setState(() =>
                        _formData.continueLogged = !_formData.continueLogged);
                  },
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        checkColor: Colors.white,
                        value: _formData.continueLogged,
                        onChanged: (value) {
                          setState(() => _formData.continueLogged = value!);
                        },
                      ),
                      Text(
                        'Continuar Logado?',
                        style: Theme.of(context).textTheme.bodySmall,
                      )
                    ],
                  ),
                ),
              ),
              Visibility(
                  visible: _formData.isLogin,
                  child: const SizedBox(height: 20)),
              Visibility(
                visible: _formData.isLogin,
                child: TextButton(
                  child: Text(
                    'Esqueceu a sua senha?',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ForgotPassPage(),
                    ));
                  },
                ),
              ),
              Visibility(
                  visible: _formData.isLogin,
                  child: const SizedBox(height: 20)),
              _formData.isLoading
                  ? CircularProgressIndicator(
                      color: Theme.of(context).colorScheme.onPrimary,
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(vertical: 12),
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        child: Text(
                          _formData.isLogin ? 'LOGAR' : 'REGISTRAR',
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
      ),
    );
  }
}
