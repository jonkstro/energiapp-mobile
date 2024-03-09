import 'package:energiapp/core/providers/device_list_provider.dart';
import 'package:energiapp/core/services/auth/auth_state_firebase_service.dart';
import 'package:energiapp/pages/widget_tree_page.dart';
import 'package:energiapp/utils/themes/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  // TODO: Só quando for buildar: Usar dart-define no build ao invés de .env
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthStateFirebaseService(),
        ),
        ChangeNotifierProxyProvider<AuthStateFirebaseService,
            DeviceListProvider>(
          // Iniciar com userId vazio e lista vazia já no construtor
          create: (_) => DeviceListProvider(),
          update: (ctx, auth, previous) {
            return DeviceListProvider(
              auth.currentUser!.id, // id do user atual logado
              previous?.items ?? [], // passando lista dos devices anteriores
            );
          },
        ),
        // add outros providers, se necessário...
      ],
      child: MaterialApp(
        title: 'EnergiApp',
        theme: MyTheme.lightTheme,
        darkTheme: MyTheme.darkTheme,
        home: const WidgetTreePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
