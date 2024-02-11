import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ErrorSnackbar {
  static void show(BuildContext context, dynamic error) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _mapFirebaseError(error),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
          ),
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  static String _mapFirebaseError(dynamic error) {
    if (error is FirebaseAuthException) {
      return _mapFirebaseAuthErrorCode(error);
    } else if (error is String) {
      return error;
    } else {
      return 'Erro desconhecido: $error';
    }
  }

  static String _mapFirebaseAuthErrorCode(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-credential':
        return 'Credenciais incorretas.';
      case 'email-already-in-use':
        return 'O endereço de email já está sendo usado.';
      default:
        return 'Erro de autenticação: ${error.message}';
    }
  }
}
