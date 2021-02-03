import 'package:http/http.dart' as http;
import 'dart:convert';
import '../env.dart';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,&$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:C%7C$latitude,$longitude&key=$kGOOGLE_API_KEY';
  }

  static Future<String> getPlaceAddress(double lat, double lng) async {
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$kGOOGLE_API_KEY';
    final response = await http.get(url);
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
