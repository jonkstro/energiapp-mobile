import 'package:energiapp/components/background_widget.dart';
import 'package:energiapp/components/device_card_widget.dart';
import 'package:energiapp/core/providers/device_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeviceListWidget extends StatelessWidget {
  const DeviceListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final deviceList = Provider.of<DeviceListProvider>(context);

    Future<void> _refreshDevices() {
      return Provider.of<DeviceListProvider>(context, listen: false)
          .loadDevices();
    }

    return BackgroundWidget(
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 10,
        child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              borderRadius: BorderRadius.circular(15),
            ),
            width: 600,
            height: 450,
            child: deviceList.itemsCount == 0
                ? const Center(child: Text('Nenhum dispositivo cadastrado!'))
                : RefreshIndicator(
                    onRefresh: () => _refreshDevices(),
                    child: ListView.builder(
                      itemCount: deviceList.itemsCount,
                      itemBuilder: (context, index) {
                        return DeviceCardWidget(
                          device: deviceList.items[index],
                        );
                      },
                    ),
                  )),
      ),
    );
  }
}
