// model dos dispositivos (medidores)
import 'package:energiapp/core/models/user_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeviceLocation {
  final double latitude;
  final double longitude;
  final String? adress;

  DeviceLocation({
    required this.latitude,
    required this.longitude,
    this.adress,
  });

  LatLng toLatLng() {
    return LatLng(latitude, longitude);
  }
}

class DeviceModel {
  final String id;
  final String name;
  final String macAdress;
  final UserModel user;
  // posso adicionar ou não a localização
  final DeviceLocation? location;
  final DateTime createdAt;

  DeviceModel({
    required this.id,
    required this.name,
    required this.macAdress,
    required this.user,
    required this.createdAt,
    this.location,
  });
}
