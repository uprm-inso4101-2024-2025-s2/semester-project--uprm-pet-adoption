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

Map<MarkerId, Marker> markers = <MarkerId, Marker>{
  MarkerId("Villa Michelle"): Marker(
      infoWindow: InfoWindow(
          title: "Villa Michelle", snippet: "telefono +1-787-834-4510"),
      markerId: MarkerId("Villa Michelle"),
      position: LatLng(18.212666922750877, -67.12830818309874)),
  MarkerId("Silver Paws PR"): Marker(
      infoWindow:
          InfoWindow(title: "Silver Paws PR", snippet: "aditional info"),
      markerId: MarkerId("Silver Paws PR"),
      position: LatLng(18.292368879983687, -67.14552825427558)),
  MarkerId("Humane Society PR"): Marker(
      infoWindow:
          InfoWindow(title: "Humane Society PR", snippet: "aditional info"),
      markerId: MarkerId("Humane Society PR"),
      position: LatLng(18.36756339597641, -66.11573767321015)),
  MarkerId("San Juan Animal Shelter"): Marker(
      infoWindow: InfoWindow(
          title: "San Juan Animal Shelter", snippet: "aditional info"),
      markerId: MarkerId("San Juan Municipality Animal Shelter"),
      position: LatLng(18.43262103793806, -66.08586202877375)),
  MarkerId("Animal Den Shelter"): Marker(
      infoWindow:
          InfoWindow(title: "Animal Den Shelter", snippet: "aditional info"),
      markerId: MarkerId("Animal Den Shelter"),
      position: LatLng(18.280305463358008, -67.14655566551384)),
  MarkerId("El Faro de los Animales"): Marker(
      infoWindow: InfoWindow(
          title: "El Faro de los Animales", snippet: "aditional info"),
      markerId: MarkerId("El Faro de los Animales"),
      position: LatLng(18.280305463358008, -67.14655566551384)),
  MarkerId("Amigo de los Animales Animal Shelter"): Marker(
      infoWindow: InfoWindow(
          title: "Amigo de los Animales Animal Shelter",
          snippet: "aditional info"),
      markerId: MarkerId("Amigo de los animales Animal Shelter"),
      position: LatLng(18.457367604371182, -65.9849927854507)),
};

final Map<MarkerId, Marker> staticShelterMarkers = <MarkerId, Marker>{
  MarkerId("Villa Michelle"): Marker(
      infoWindow: InfoWindow(
          title: "Villa Michelle", snippet: "telefono +1-787-834-4510"),
      markerId: MarkerId("Villa Michelle"),
      position: LatLng(18.212666922750877, -67.12830818309874)),
  MarkerId("Silver Paws PR"): Marker(
      infoWindow:
          InfoWindow(title: "Silver Paws PR", snippet: "aditional info"),
      markerId: MarkerId("Silver Paws PR"),
      position: LatLng(18.292368879983687, -67.14552825427558)),
  MarkerId("Humane Society PR"): Marker(
      infoWindow:
          InfoWindow(title: "Humane Society PR", snippet: "aditional info"),
      markerId: MarkerId("Humane Society PR"),
      position: LatLng(18.36756339597641, -66.11573767321015)),
  MarkerId("San Juan Animal Shelter"): Marker(
      infoWindow: InfoWindow(
          title: "San Juan Animal Shelter", snippet: "aditional info"),
      markerId: MarkerId("San Juan Municipality Animal Shelter"),
      position: LatLng(18.43262103793806, -66.08586202877375)),
  MarkerId("Animal Den Shelter"): Marker(
      infoWindow:
          InfoWindow(title: "Animal Den Shelter", snippet: "aditional info"),
      markerId: MarkerId("Animal Den Shelter"),
      position: LatLng(18.280305463358008, -67.14655566551384)),
  MarkerId("El Faro de los Animales"): Marker(
      infoWindow: InfoWindow(
          title: "El Faro de los Animales", snippet: "aditional info"),
      markerId: MarkerId("El Faro de los Animales"),
      position: LatLng(18.280305463358008, -67.14655566551384)),
  MarkerId("Amigo de los Animales Animal Shelter"): Marker(
      infoWindow: InfoWindow(
          title: "Amigo de los Animales Animal Shelter",
          snippet: "aditional info"),
      markerId: MarkerId("Amigo de los animales Animal Shelter"),
      position: LatLng(18.457367604371182, -65.9849927854507)),
};

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapScreenState();
}

class _MapScreenState extends State<Maps> {
  // Choose a valid center coordinate (e.g. UPRM)
  static const LatLng _center = LatLng(18.2109, -67.1409);

  // Use a Completer to manage the GoogleMapController
  final Completer<GoogleMapController> _mapController = Completer();
  final TextEditingController _searchController = TextEditingController();
  LatLng position = const LatLng(0, 0);
  List<Place> places = [];
  int currentPlace = 0;

  bool showVets = false;
  bool showPetStores = false;
  bool showShelters = false;

  Future<void> search(String address) async {
    final controller = await _mapController.future;
    final location = await getLatLngFromAddress(address, API_KEY);
    if (location != null) {
      controller.animateCamera(CameraUpdate.newLatLng(location));
      // call add location to markers map function
      addLocation(address, location);
      position = location;
      await updateNearbyMarkers();
    }
  }

  Future<void> updateNearbyMarkers() async {
    markers.clear();
    addLocation("You", position);

    List<String> types = [];
    if (showVets) types.add("veterinary_care");
    if (showPetStores) types.add("pet_store");

    if (showShelters) {
      markers.addAll(staticShelterMarkers);
    }

    for (String type in types) {
      final results = await getNearbyPlaces(position, 5000, [type], API_KEY);
      for (var place in results) {
        final markerId = MarkerId(place.name);
        final marker = Marker(
          markerId: markerId,
          position: place.location,
          infoWindow: InfoWindow(title: place.name),
        );
        markers[markerId] = marker;
      }
    }

    setState(() {});
  }

  void addLocation(String address, LatLng location) {
    setState(() {
      markers[MarkerId("self")] =
          Marker(markerId: MarkerId("self"), position: location);
    });
  }

  @override
  void initState() {
    super.initState();
    search("University of Puerto Rico Mayaguez");
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);
  }
  // Zooms out to have a broader range of view depending on the filter chosen.
  Future<void> zoomToUserLocation() async {
    final controller = await _mapController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: position, // wherever you last searched or centered
          zoom: 12.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
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
            // markers: {Marker(markerId: const MarkerId("self"),position: _center)},
            markers: Set<Marker>.of(markers.values),
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
          // Filter Buttons Row (below your search bar)
          Positioned(
            top: 90,
            left: 0,
            right: 0,
            child: Row(
              mainAxisSize: MainAxisSize.min, // keeps buttons centered
              children: [
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        showShelters ? Colors.black : const Color(0xFFFFF581),
                    foregroundColor: showShelters ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8), // tighter padding
                    minimumSize: const Size(0, 0),
                  ),
                  onPressed: () {
                    setState(() {
                      showShelters = !showShelters;
                    });
                    updateNearbyMarkers();
                    zoomToUserLocation();
                  },
                  child: const Text('Our Shelters',
                      style: TextStyle(fontFamily: 'Archivo', fontSize: 13)),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        showPetStores ? Colors.black : const Color(0xFFFFF581),
                    foregroundColor:
                        showPetStores ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8), // tighter padding
                    minimumSize: const Size(0, 0),
                  ),
                  onPressed: () {
                    setState(() {
                      showPetStores = !showPetStores;
                    });
                    updateNearbyMarkers();
                    zoomToUserLocation();
                  },
                  child: const Text('Nearby Pet Stores',
                      style: TextStyle(fontFamily: 'Archivo', fontSize: 13)),
                ),
                const SizedBox(width: 5),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        showVets ? Colors.black : const Color(0xFFFFF581),
                    foregroundColor: showVets ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8), // tighter padding
                    minimumSize: const Size(0, 0),
                  ),
                  onPressed: () {
                    setState(() {
                      showVets = !showVets;
                    });
                    updateNearbyMarkers();
                    zoomToUserLocation();
                  },
                  child: const Text('Nearby Vets',
                      style: TextStyle(fontFamily: 'Archivo', fontSize: 13)),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 3),
    );
  }
}
