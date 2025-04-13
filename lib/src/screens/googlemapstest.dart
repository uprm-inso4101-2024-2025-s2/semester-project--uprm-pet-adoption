import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/main.dart';
import 'package:semester_project__uprm_pet_adoption/supabase/retrieval.dart';
import 'package:semester_project__uprm_pet_adoption/supabase/upload.dart';
import '../services/storage_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';
import 'dart:async';
import 'package:semester_project__uprm_pet_adoption/src/screens/utils.dart';


const API_KEY = "AIzaSyBcV8dRIngCERq1s-Opezvj8BhV8Z-kzvU";

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapScreenState();
}

class _MapScreenState extends State<Maps> {
  // Choose a valid center coordinate (e.g., San Juan, PR)
  static const LatLng _center = LatLng(18.2109, -67.1409);
  // Use a Completer to manage the GoogleMapController
  final Completer<GoogleMapController> _mapController = Completer();
  final TextEditingController _searchController = TextEditingController();
  LatLng position = const LatLng(0, 0);

  Future<void> search(String address) async {
    final controller = await _mapController.future;
    final location = await getLatLngFromAddress(address, API_KEY);
    if (location != null) {
      controller.animateCamera(CameraUpdate.newLatLng(location));
    }
  }

   @override
  void initState() {
    super.initState();
    search("University of Puerto Rico Mayaguez");
  }


  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nearby Shelters!'),
        backgroundColor: const Color(0xFFFFF581),
      ),
      body: Stack(
        children: [
          // The Google Map widget in the background.
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 16.0,
            ),
          ),
          // The search bar positioned on top of the map.
          Positioned(
            top: 20,
            left: 15,
            right: 15,
            child: Material(
              elevation: 5.0,
              borderRadius: BorderRadius.circular(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: "location...",
                  border: InputBorder.none,
                  prefixIcon: const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 131, 131, 131),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                    },
                    icon: const Icon(
                      Icons.highlight_remove,
                      color: Color.fromARGB(255, 131, 131, 131),
                    ),
                  ),
                  contentPadding: const EdgeInsets.all(15.0),
                ),
                onSubmitted: (value) {
                  // Call the search function when the user submits a query.
                  search(value);
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
