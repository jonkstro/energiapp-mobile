import 'package:energiapp/components/teste_services.dart';
import 'package:flutter/material.dart';

class EmailValidationPage extends StatelessWidget {
  const EmailValidationPage({super.key});

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
