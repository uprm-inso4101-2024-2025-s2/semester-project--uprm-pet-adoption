import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/main.dart';
import 'package:semester_project__uprm_pet_adoption/supabase/retrieval.dart';
import 'package:semester_project__uprm_pet_adoption/supabase/upload.dart';
import '../services/storage_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';

class MapsHeader extends StatelessWidget {
  const MapsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 5),
      decoration: const BoxDecoration(
        // Setting background image
        image: DecorationImage(
          image: AssetImage('images/Login_SignUp_Background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            //input desired location
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                hintText: "location...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                fillColor: const Color.fromARGB(255, 243, 243, 243),
                filled: true,
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 131, 131, 131),
                ),
                suffixIcon: IconButton(
                    onPressed: () {
                      //delete current location
                    },
                    icon: const Icon(
                      Icons.highlight_remove,
                      color: const Color.fromARGB(255, 131, 131, 131),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Mapsfooter extends StatelessWidget {
  const Mapsfooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('images/Login_SignUp_Background.png'),
          fit: BoxFit.cover,
        ),
        color: const Color(0xFF82B0FF),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.only(bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Distance & Duration blocks
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Icon(Icons.map_outlined, size: 32, color: Color(0xFFFFF581)),
                  SizedBox(height: 4),
                  Text('Distance',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('25 km',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                children: const [
                  Icon(Icons.access_time_filled,
                      size: 32, color: Color(0xFFFFF581)),
                  SizedBox(height: 4),
                  Text('Duration',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                  Text('10 min',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {
              // Add directions logic here
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFF581),
              foregroundColor: Colors.black,
              minimumSize: const Size(200, 45),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              'DIRECTIONS',
              style: TextStyle(
                fontFamily: 'Archivo',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Maps extends StatelessWidget {
  const Maps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: const MapsHeader(),
      ),
      body: Stack(
        children: [
          // Background map
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/temp_map_img.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Filter buttons row
          Column(
            children: [
              const SizedBox(height: 15),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFF581),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(25, 25),
                      ),
                      onPressed: () {},
                      child: const Text('Shelters',
                          style:
                              TextStyle(fontFamily: 'Archivo', fontSize: 20)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFF581),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(25, 25),
                      ),
                      onPressed: () {},
                      child: const Text('Rescues',
                          style:
                              TextStyle(fontFamily: 'Archivo', fontSize: 20)),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFF581),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(25, 25),
                      ),
                      onPressed: () {},
                      child: const Text('Vet',
                          style:
                              TextStyle(fontFamily: 'Archivo', fontSize: 20)),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ),
            ],
          ),

          // Floating location + zoom controls
          Positioned(
            bottom: 220,
            right: 16,
            child: SizedBox(
              width: 60,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image(
                    image:
                        const AssetImage("assets/images/map_location_icon.png"),
                    width: 60,
                    height: 60,
                  ),
                  const SizedBox(height: 8),

                  // Zoom In
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 200, 200, 200),
                      border: Border.all(color: Colors.black),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add, size: 20),
                      padding: EdgeInsets.zero,
                      color: Colors.black,
                    ),
                  ),

                  // Zoom Out
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 201, 201, 201),
                      border: Border.all(color: Colors.black),
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove, size: 20),
                      padding: EdgeInsets.zero,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Footer
          const Align(
            alignment: Alignment.bottomCenter,
            child: Mapsfooter(),
          ),
        ],
      ),
    );
  }
}
