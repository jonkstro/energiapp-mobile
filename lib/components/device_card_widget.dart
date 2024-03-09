import 'package:energiapp/core/models/device_model.dart';
import 'package:flutter/material.dart';

class DeviceCardWidget extends StatelessWidget {
  final DeviceModel device;
  const DeviceCardWidget({super.key, required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Image(
            image: AssetImage('assets/images/icone-medidor-claro.png'),
            width: 50,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          device.macAdress,
          textAlign: TextAlign.right,
        ),
        subtitle: Text(
          device.location?.adress ?? 'Sem endereço',
          textAlign: TextAlign.right,
          maxLines: 2, // Defina o número máximo de linhas desejado
          overflow: TextOverflow.ellipsis, // Adiciona "..." em caso de overflow
          softWrap: true,
        ),
        // TODO: Adicionar funcionalidade de navegar para tela de detalhes do dispositivo
        onTap: () {},
      ),
    );
  }
}
