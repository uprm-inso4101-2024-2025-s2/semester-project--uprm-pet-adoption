import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Converts an address into geographic coordinates (latitude and longitude)
/// using the Google Geocoding API.
///
/// - [address]: The street address or place name to geocode.
/// - [apiKey]: Your Google Maps API key with Geocoding API enabled.
///
/// Returns a [LatLng] representing the geocoded location if successful,
/// or `null` if the address could not be resolved or an error occurred.
Future<LatLng?> getLatLngFromAddress(String address, String apiKey) async {
  // Encode address for use in URL
  final encodedAddress = Uri.encodeComponent(address);
  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$apiKey',
  );

  try {
    // Send GET request to Geocoding API
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Parse JSON response
      final decoded = json.decode(response.body);

      // Check API status and presence of results
      if (decoded['status'] == 'OK' &&
          (decoded['results'] as List).isNotEmpty) {
        final location = decoded['results'][0]['geometry']['location'];
        final lat = location['lat'];
        final lng = location['lng'];

        return LatLng(lat, lng);
      } else {
        // API returned no results or an error status
        print('Geocoding API Error: ${decoded['status']}');
        return null;
      }
    } else {
      // HTTP request failed
      print('HTTP Error: ${response.statusCode}');
      return null;
    }
  } catch (e) {
    // Exception occurred during request or parsing
    print('Error during geocoding: $e');
    return null;
  }
}

/// Represents a place of interest returned by the Places API.
class Place {
  /// Display name of the place.
  final String name;

  /// Geographic coordinates of the place.
  final LatLng location;

  /// Constructs a [Place] with the given [name] and [location].
  Place({required this.name, required this.location});
}

/// Fetches nearby places of specified [types] around a central [location]
/// using the Google Places Nearby Search API.
///
/// - [location]: The central coordinates to search around.
/// - [radius]: The search radius in meters.
/// - [types]: A list of place type strings (e.g. 'pet_store', 'veterinary_care').
/// - [apiKey]: Your Google Maps API key with Places API enabled.
///
/// Returns a list of [Place] objects representing each matching location,
/// or an empty list if the request fails or no places are found.
Future<List<Place>> getNearbyPlaces(
  LatLng location,
  int radius,
  List<String> types,
  String apiKey,
) async {
  // Build the 'type' parameter by joining multiple types with '|'
  final typeParam = types.join('|');
  final url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
      'location=${location.latitude},${location.longitude}'
      '&radius=$radius'
      '&type=$typeParam'
      '&key=$apiKey';

  // Perform HTTP GET request
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    // Decode JSON response
    final data = json.decode(response.body);
    final results = data['results'] as List;

    // Map each JSON result to a Place instance
    return results.map((placeJson) {
      final name = placeJson['name'];
      final lat = placeJson['geometry']['location']['lat'];
      final lng = placeJson['geometry']['location']['lng'];
      return Place(name: name, location: LatLng(lat, lng));
    }).toList();
  } else {
    // Log failure and return empty list
    print('Failed to fetch places: ${response.body}');
    return [];
  }
}
