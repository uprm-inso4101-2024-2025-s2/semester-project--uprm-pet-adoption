import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LatLng?> getLatLngFromAddress(String address, String apiKey) async {
  final encodedAddress = Uri.encodeComponent(address);
  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey'
  );

  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      if (decoded['status'] == 'OK' && (decoded['results'] as List).isNotEmpty) {
        final location = decoded['results'][0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];
        return LatLng(lat, lng);
      } else {
        print('Geocoding API Error: ${decoded['status']}');
        return null;
      }
    } else {
      print('HTTP Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    print('Error during geocoding: $e');
    return null;
  }
}
