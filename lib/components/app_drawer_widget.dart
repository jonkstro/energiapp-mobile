import 'package:energiapp/core/services/auth/auth_state_service.dart';
import 'package:energiapp/pages/widget_tree_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppDrawerWidget extends StatelessWidget {
  const AppDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
              child: Column(
            children: [
              const SizedBox(
                height: 50,
                child: Text('Selecione o que deseja:'),
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Configurações'),
                // TODO: Adicionar funcionalidade de navegar para tela de configurações
                onTap: () {},
              ),
            ],
          )),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: const Icon(Icons.logout),
              label: const Text('SAIR'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () async {
                await AuthStateService().logout().then((value) =>
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) {
                        return const WidgetTreePage();
                      },
                    )));
              },
            ),
          ),
        ],
      ),
    );
  }
}
