// model dos dispositivos (medidores)
import 'package:energiapp/core/models/user_model.dart';

class DeviceModel {
  final String id;
  final String macAdress;
  final String endereco;
  final UserModel user;
  final DateTime createdAt;

  DeviceModel({
    required this.id,
    required this.macAdress,
    required this.endereco,
    required this.user,
    required this.createdAt,
  });
}
