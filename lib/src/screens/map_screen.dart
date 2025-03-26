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
                          prefixIcon: Icon(Icons.location_on,color: const Color.fromARGB(255, 131, 131, 131),),
                          suffixIcon: IconButton(
                              onPressed: (){
                                //delete current location
                        
                              }, icon: const Icon(Icons.highlight_remove,color: const Color.fromARGB(255, 131, 131, 131),)),
                              
                        ),
                      ),
                    ),

            ],

      ),
    );
  }
}


//placeholder for duration,distance and directions bottom section
class Mapsfooter extends StatelessWidget {
  const Mapsfooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250, // adjust the height as needed
    
      decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
            ),
            image: DecorationImage(image: AssetImage('images/Login_SignUp_Background.png'),fit:BoxFit.cover)
       ),
      
      
    );
    
  }
}


class Maps extends StatelessWidget {
  const Maps({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Custom header using PreferredSize to control height
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: const MapsHeader(),
      ),

      // Main body with background map image
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/temp_map_img.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            // Main content column
            Column(
              children: [
                const SizedBox(height: 15),

                // Horizontally scrollable filter buttons (e.g., Shelters, Rescues, Vet)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(width: 10),
                      // Shelter Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFF581),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(25, 25),
                        ),
                        onPressed: () {
                          // Handle "Shelters" tap
                        },
                        child: const Text(
                          'Shelters',
                          style: TextStyle(
                            fontFamily: 'Archivo',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Rescue Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFF581),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(25, 25),
                        ),
                        onPressed: () {
                          // Handle "Rescues" tap
                        },
                        child: const Text(
                          'Rescues',
                          style: TextStyle(
                            fontFamily: 'Archivo',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Vet Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFF581),
                          foregroundColor: Colors.black,
                          minimumSize: const Size(25, 25),
                        ),
                        onPressed: () {
                          // Handle "Vet" tap
                        },
                        child: const Text(
                          'Vet',
                          style: TextStyle(
                            fontFamily: 'Archivo',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Add more buttons if needed...
                    ],
                  ),
                ),

                const SizedBox(height: 250),
                // Additional space to make room for floating elements/icons
              ],
            ),

            // Floating image icon and control buttons (Zoom In/Out)
            Positioned(
              bottom: -90,
              right: 0,
              child: SizedBox(
                width: 50,
                height: 500,
                child: Stack(
                  children: [
                    // Location icon
                    Positioned(
                      top: 220,
                      left: -20,
                      child: Image(
                        image: AssetImage("assets/images/map_location_icon.png"),
                        width: 80,
                        height: 80,
                      ),
                    ),

                    // "+" (Zoom In) button
                    Positioned(
                      top: 310,
                      left: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 200, 200, 200),
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0), width: 1),
                        ),
                        child:  IconButton(
                          onPressed: (){},
                          icon: Icon(Icons.add),
                          color: Color.fromARGB(255, 0, 0, 0),
                          // size: 40,
                        ),
                      ),
                    ),

                    // "−" (Zoom Out) button
                    Positioned(
                      top: 350,
                      left: 0,
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 201, 201, 201),
                          border: Border.all(
                              color: const Color.fromARGB(255, 0, 0, 0), width: 1),
                        ),
                        child:  IconButton(
                          onPressed: (){

                          },
                          icon:Icon(Icons.remove),
                          color: Color.fromARGB(255, 0, 0, 0),
                          // size: 40,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Two stacked bottom sections: custom footer and bottom navigation bar
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Mapsfooter(), // Custom bottom widget (e.g., curved container)
          BottomNavBar(selectedIndex: 0), // Main bottom navigation bar
        ],
      ),
    );
  }
}
