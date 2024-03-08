import 'package:energiapp/core/models/device_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsPage extends StatefulWidget {
  final bool isReadOnly;
  final DeviceLocation initialLocation;
  const MapsPage({
    super.key,
    required this.isReadOnly,
    required this.initialLocation,
  });

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  LatLng? _pickedPosition;

  //! método que vai escolher a posição ao clicar na tela do mapa
  void _selectPosition(LatLng position) {
    if (mounted) setState(() => _pickedPosition = position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione no mapa'),
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              icon: const Icon(Icons.check),
              // botão vai ficar desabilitado até o user escolher uma localização
              onPressed: _pickedPosition == null
                  ? null
                  : () {
                      // Vai fechar a página retornando a localização selecionada pelo usuário
                      Navigator.of(context).pop(_pickedPosition);
                    },
            ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude,
          ),
          zoom: 13,
        ),
        //! ao clicar, vai chamar o método de escolher posição
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: (_pickedPosition == null && !widget.isReadOnly)
            // caso não tenham escolhido a posição ainda, não tem marcador
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('p1'),
                  position: // adicionar marcador na posição escolhida
                      _pickedPosition ?? widget.initialLocation.toLatLng(),
                ),
              },
      ),
    );
  }
}
