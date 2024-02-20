import 'package:energiapp/core/models/device_model.dart';
import 'package:flutter/material.dart';

class DeviceListProvider with ChangeNotifier {
  List<DeviceModel> _items = [];

  List<DeviceModel> get items => [..._items];

  int get itemsCount => _items.length;
}
