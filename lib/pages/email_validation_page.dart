import 'package:energiapp/components/teste_services.dart';
import 'package:energiapp/core/models/user_model.dart';
import 'package:flutter/material.dart';

class EmailValidationPage extends StatelessWidget {
  final UserModel user;
  const EmailValidationPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Email Validation Page'),
            TesteServices(),
          ],
        ),
      ),
    );
  }
}
