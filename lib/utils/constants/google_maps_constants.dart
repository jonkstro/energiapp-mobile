import 'package:flutter_dotenv/flutter_dotenv.dart';

class GoogleMapsConstants {
  static final googleApiKey = dotenv.env['MAPS_API_KEY'] ?? '';
}
