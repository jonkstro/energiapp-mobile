import 'package:energiapp/components/app_drawer_widget.dart';
import 'package:energiapp/components/device_form_widget.dart';
import 'package:energiapp/components/device_list_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _openNewDeviceModal() {
    final mediaQuery = MediaQuery.of(context);
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return OrientationBuilder(
          builder: (context, orientation) {
            double height = mediaQuery.size.height;
            return SizedBox(
              height: height * 0.80,
              child: const DeviceFormWidget(),
            );
          },
        );
      },
      isScrollControlled: true,
    );
  }

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
          onPressed: () => _openNewDeviceModal(),
        ),
      ),
    );
  }
}
