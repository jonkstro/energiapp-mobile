import 'package:energiapp/components/app_drawer_widget.dart';
import 'package:energiapp/components/device_form_widget.dart';
import 'package:energiapp/components/device_list_widget.dart';
import 'package:energiapp/core/providers/device_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    Provider.of<DeviceListProvider>(context, listen: false).loadDevices();
    if (mounted) setState(() => _isLoading = false);
  }

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
        body: Stack(
          children: [
            const DeviceListWidget(),
            Visibility(
              visible: _isLoading,
              child: Container(
                color: const Color.fromRGBO(0, 0, 0, 0.5),
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(backgroundColor: Colors.white),
                      SizedBox(height: 10),
                      Text(
                        'Carregando...',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
