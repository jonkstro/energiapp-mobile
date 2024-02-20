import 'package:energiapp/components/app_drawer_widget.dart';
import 'package:energiapp/components/device_list_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.onBackground,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        drawer: const AppDrawerWidget(),
        body: const DeviceListWidget(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Colors.black,
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
          // TODO: Criar método que vai chamar Modal pra criar dispositivo
          onPressed: () {},
        ),
      ),
    );
  }
}
