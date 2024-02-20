import 'package:energiapp/components/background_widget.dart';
import 'package:energiapp/components/forgot_pass_form_widget.dart';
import 'package:flutter/material.dart';

class ForgotPassPage extends StatelessWidget {
  const ForgotPassPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
        ),
        body: const BackgroundWidget(
          child: ForgotPassFormWidget(),
        ),
      ),
    );
  }
}
