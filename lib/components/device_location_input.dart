import 'package:energiapp/core/models/device_model.dart';
import 'package:energiapp/pages/maps_page.dart';
import 'package:energiapp/utils/location_util.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

/// Essa classe será responsável por realizar a tratativa de pegar a localização do user/abrir
/// o google maps para o user escolher a localização.
/// Essa classe irá retornar um LatLng para o widget pai poder tratar no provider do objeto
class DeviceLocationInput extends StatefulWidget {
  final Function onSelectPosition;
  const DeviceLocationInput({super.key, required this.onSelectPosition});

  @override
  State<DeviceLocationInput> createState() => _DeviceLocationInputState();
}

class _DeviceLocationInputState extends State<DeviceLocationInput> {
  String? _enderecoAtual;
  bool _isLoading = false;

  //! Método que irá buscar a localização atual do usuário
  Future<void> _getCurrentUserLocation() async {
    if (mounted) setState(() => _isLoading = true);
    final locData = await Location().getLocation();
    // transformar em LatLng (que está sendo usado na model)
    final locDataLatLng = LatLng(
      locData.latitude!,
      locData.longitude!,
    );
    // aguardar realizar a requisição http do google maps
    final userLocation = await LocationUtil.getAdressFrom(locDataLatLng);
    if (mounted) {
      setState(() {
        _enderecoAtual = userLocation;
        _isLoading = false;
      });
    }
    // chamar o método lá do device form para atribuir o valor LatLng no objeto
    widget.onSelectPosition(locDataLatLng);
  }

  //! Método que irá abrir a tela do google maps pro usuário escolher no mapa
  Future<void> _selectOnMap() async {
    if (mounted) setState(() => _isLoading = true);

    // pegar a localização atual pra ser a inicial do google maps
    final locData = await Location().getLocation();
    final LatLng? selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => MapsPage(
          isReadOnly: false,
          initialLocation: DeviceLocation(
            adress: null,
            // se não achar a localização atual, vai iniciar na sede do google
            latitude: locData.latitude ?? 37.419857,
            longitude: locData.longitude ?? -122.078827,
          ),
        ),
      ),
    );
    // se o user fechar o mapa sem escolher a posição, vai fazer nada
    if (selectedPosition == null) {
      if (mounted) setState(() => _isLoading = false);
      return;
    }
    final selectedAdress = await LocationUtil.getAdressFrom(selectedPosition);
    if (mounted) {
      setState(() {
        _enderecoAtual = selectedAdress;
        _isLoading = false;
      });
    }
    // chamar o método lá do device form para atribuir o valor LatLng no objeto
    widget.onSelectPosition(selectedPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: <Widget>[
          Text(
            'Localização do dispositivo:',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            _enderecoAtual != null
                ? _enderecoAtual!
                : 'Selecione a localização abaixo',
            style: Theme.of(context).textTheme.bodySmall,
            softWrap: true,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 600),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.location_on),
              label: _isLoading
                  ? const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Pegar minha localização atual'),
              onPressed: _isLoading ? null : () => _getCurrentUserLocation(),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(12),
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 600),
            child: ElevatedButton.icon(
              icon: const Icon(Icons.map),
              label: _isLoading
                  ? const SizedBox(
                      height: 15,
                      width: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Escolher localização no mapa'),
              onPressed: _isLoading ? null : () => _selectOnMap(),
            ),
          ),
        ],
      ),
    );
  }
}
