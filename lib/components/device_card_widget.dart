import 'package:flutter/material.dart';

class DeviceCardWidget extends StatelessWidget {
  const DeviceCardWidget({super.key});

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
        title: const Text(
          '34-EA-56-5A-66-BE',
          textAlign: TextAlign.right,
        ),
        subtitle: const Text(
          'Av. Dep. Pinheiro Machado, 1 - Rodoviária, Parnaíba - PI',
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
