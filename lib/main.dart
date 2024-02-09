import 'package:energiapp/pages/home_page.dart';
import 'package:energiapp/pages/splash_screen.dart';
import 'package:energiapp/utils/themes/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Inicializa o Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EnergiApp',
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      home: SplashScreen(),
    );
  }
}
