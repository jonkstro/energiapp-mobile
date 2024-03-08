import 'package:energiapp/core/models/device_model.dart';
import 'package:flutter/material.dart';

class DeviceListProvider with ChangeNotifier {
  List<DeviceModel> _items = [];

  List<DeviceModel> get items => [..._items];

  int get itemsCount => _items.length;

  // TODO: Criar método de Listar todos dispositivos
  // TODO: Criar método de adicionar novo dispositivo
  // TODO: Criar método de atualizar dispositivo existente
  // TODO: Criar método de deletar dispositivo existente
}

/**
 * void addPlace(
    String title,
    File image,
    LatLng position,
  ) async {
    *!String address = await LocationUtil.getAdressFrom(position);
    final newPlace = Place(
       id: Random().nextDouble().toString(),
      title: title,
      image: image,
      *!location: PlaceLocation(
        *!address,
        *!latitude: position.latitude,
        *!longitude: position.longitude,
      ),
    );

    _items.add(newPlace);
    // Adicionar no SQLite
    DbUtil.insert(Constantes.tbName, {
      'id': newPlace.id,
      'title': newPlace.title,
      // Vamos adicionar só o path da imagem que já tá salvo na pasta do projeto
      'image': newPlace.image.path,
      'lat': position.latitude,
      'lng': position.longitude,
      'address': address,
    });
    notifyListeners();
  }
 */
