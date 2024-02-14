import 'package:energiapp/components/logo_container_widget.dart';
import 'package:energiapp/core/models/user_model.dart';
import 'package:energiapp/core/services/auth/auth_state_firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    AuthStateFirebaseService auth =
        Provider.of<AuthStateFirebaseService>(context);
    UserModel? user = auth.currentUser;
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
                  child: Card(
                      child: Text(
                          'User logado: ${user?.name} expira às ${user?.expiresAt} e foi criado as ${user?.createdAt}')),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}
