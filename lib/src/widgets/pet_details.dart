import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:file_picker/file_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// PetDetails Widget
/// -----------------
/// This widget represents a pet profile card with front and back views.
/// It dynamically displays pet details and handles interactions.
///
/// **Usage:**
/// - Do **not** use this widget directly in other screens.
/// - Always wrap it inside `PetScreen` to maintain proper layout and styling.
/// - `PetScreen` ensures the correct background, navigation, and positioning.
///
/// **Example Usage (Handled inside `petDetails_screen`):**
///
/// ```dart
/// PetDetails(
///   petName: "Firulai",
///   petBreed: "Golden Retriever",
///   petLocation: "San Juan, PR",
///   petAge: "2",
///   petImage: "images/pet_placeholder.png",
///   petSex: "Male",
///   petWeight: "7",
///   petHeight: "40",
///   petDistance: "2",
///   isFavorite: false,
///   onFavoriteToggle: () {},
///   onAdopt: () {},
/// )
/// ```
///
/// **Key Notes:**
/// - `PetDetails` is a **widget**, not a full screen.
/// - Any layout modifications should be made in `PetScreen`, not here.
/// - It supports interactive features like toggling favorites and adoption actions.

class PetDetails extends StatefulWidget {
  final String petName;
  final String petBreed;
  final String petLocation;
  final String petAge;
  final String petImage;
  final String petSex;
  final String petWeight;
  final String petHeight;
  final String petDistance;
  final bool isFavorite;
  final VoidCallback onFavoriteToggle;
  final VoidCallback onAdopt;

  const PetDetails({
    Key? key,
    required this.petName,
    required this.petBreed,
    required this.petLocation,
    required this.petAge,
    required this.petImage,
    required this.petSex,
    required this.petWeight,
    required this.petHeight,
    required this.petDistance,
    required this.isFavorite,
    required this.onFavoriteToggle,
    required this.onAdopt,
  }) : super(key: key);

  @override
  _PetDetailsState createState() => _PetDetailsState();
}

class _PetDetailsState extends State<PetDetails> {
  bool _showBack = false; // Tracks whether to show front or back of the card

  void _toggleCard() {
    setState(() {
      _showBack = !_showBack; // Flips the card on tap
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: _toggleCard, // Switch between front and back views
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (widget, animation) {
            return ScaleTransition(scale: animation, child: widget);
          },
          child: _showBack ?  _buildFrontView():_buildBackView(),
        ),
      ),
    );
  }

  /// Builds the front view of the pet card
  Widget _buildFrontView() {
    return Stack(
      alignment: Alignment.topCenter, // Align sign_log at the top
      children: [
        Positioned(
          top: -50,
          height: 300,
          width: 250,
          child: Image.asset(
            'assets/images/sign_log.png', //  Keep sign_log outside the card
            width:
                MediaQuery.of(context).size.width * 0.4, // Scale appropriately
          ),
        ),

        // Main pet image inside a card
        Center(
          child: Card(
            color: Colors.white.withOpacity(0.85),
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8, // Set card width
              height:
                  MediaQuery.of(context).size.height * 0.5, // Set card height
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                 widget.petImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),

        // "More Info" text with icon at the top right of the card
        Positioned(
          top: 210,
          right: 60,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "More Info",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 5),
                const Icon(
                  Icons.info_outline,
                  color: Colors.white,
                  size: 18,
                ),
              ],
            ),
          ),
        ),

        // Pet's basic info displayed at the bottom-left of the image
        Positioned(
          bottom: 200,
          left: 53,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.petName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "${widget.petAge} years old",
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
                Text(
                  widget.petLocation,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Two Heart Icons Below Card
        Positioned(
          bottom: 120, // Adjust position below the card
          left:
              MediaQuery.of(context).size.width * 0.5 - 95, // Center the hearts
          child: Row(
            mainAxisSize: MainAxisSize.min, // Keeps row compact
            children: [
              GestureDetector(
                onTap: widget.onFavoriteToggle, // Make it interactive
                child: Icon(
                  Icons.heart_broken_outlined,
                  color: widget.isFavorite
                      ? Colors.amberAccent
                      : Colors.amberAccent, // Toggle favorite
                  size: 60,
                ),
              ),
              const SizedBox(width: 80), // Spacing between hearts
              GestureDetector(
                onTap: widget
                    .onFavoriteToggle, // Same functionality for second heart
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: widget.isFavorite
                      ? Colors.amberAccent
                      : Colors.amberAccent,
                  size: 60,
                ),
              ),
            ],
          ),
        ),

        // Bottom black navigation bar
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 90,
            width: double.infinity,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Icon(Icons.home, color: Colors.amberAccent, size: 40),
                // Icon(Icons.message, color: Colors.amberAccent, size: 40),
                // Icon(Icons.search_rounded, color: Colors.amberAccent, size: 40),
                // Icon(Icons.location_on, color: Colors.amberAccent, size: 40),
                // Icon(Icons.person, color: Colors.amberAccent, size: 40),

              
                IconButton(
                  onPressed: () => context.go('/'), 
                  icon: Icon(Icons.home,size:40 ),
                  color: Colors.amberAccent,
                  
                ),
                IconButton(
                  onPressed: () => context.go('/chat'), 
                  icon: Icon( Icons.message,size:40 ),
                  color: Colors.amberAccent,
                  
                ),
                IconButton(
                  onPressed: () => context.go('/petProfile'), 
                  icon: Icon( Icons.add_circle_outline,size:40 ),
                  color: Colors.amberAccent,
                  
                ),
                IconButton(
                  onPressed: () => context.go('/map'), 
                  icon: Icon( Icons.location_on,size:40 ),
                  color: Colors.amberAccent,
                  
                ),
                IconButton(
                  onPressed: () => context.go('/profile'), 
                  icon: Icon( Icons.person,size:40 ),
                  color: Colors.amberAccent,
                  
                ),
                
              ],
            ),
          ),
        )
      ],
    );
  }

  /// Builds the back view of the pet card
  Widget _buildBackView() {
    return Stack(
      children: [
        // Top blue bar with logo and menu icon
        SafeArea(
          child: Positioned(
            child: Container(
              width: double.infinity,
              height: 90,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 98, 154, 250),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical:0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/sign_log.png',
                    height: 100,
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu,
                        color: Colors.amberAccent, size: 30),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),

        // Pet details card
        Center(
          child: Card(
            color: Colors.white,
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              padding: const EdgeInsets.all(10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: const Color.fromARGB(255, 98, 154, 250),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              widget.petImage,
                              height: 200,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.petName,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black)),
                                Text("${widget.petAge} years old",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                                Text(widget.petLocation,
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),

                                const SizedBox(
                                    height: 8), // Space between sections

                                Text("Sex: ${widget.petSex}",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                                Text("Weight: ${widget.petWeight} kg",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                                Text("Height: ${widget.petHeight} cm",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                                Text("Distance: ${widget.petDistance} km away",
                                    style: const TextStyle(
                                        fontSize: 14, color: Colors.black)),
                              ],
                            ),
                      ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Description inside a white box
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          children: [
                            const Text("Hello...",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                            const SizedBox(height: 5),
                            const Text(
                                "I am playful and lovable. I love the beach and to sleep.",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.black)),
                          ],
                        ),
                      ),

                      const Spacer(),

                      // "Adopt Me" Button with Heart Icon
                      Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Adopt Me Button
                            ElevatedButton(
                              onPressed: widget.onAdopt,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor:
                                    const Color.fromARGB(255, 0, 6, 11),
                              ),
                              child: const Text("Adopt me!",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),

                            // Heart Icon
                            Icon(
                              Icons.favorite,
                              color: Colors.amberAccent,
                              size: 30,
                            ),
                            const SizedBox(
                                width:
                                    10), // spacing between the heart and button
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Bottom Bar
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 90,
            width: double.infinity,
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children:  [
                // Icon(Icons.home, color: Colors.amberAccent, size: 40),
                // Icon(Icons.message, color: Colors.amberAccent, size: 40),
                // Icon(Icons.search_rounded, color: Colors.amberAccent, size: 40),
                // Icon(Icons.location_on, color: Colors.amberAccent, size: 40),
                // Icon(Icons.person, color: Colors.amberAccent, size: 40),
                IconButton(
                  onPressed: () => context.go('/'), 
                  icon: Icon(Icons.home,size:40 ),
                  color: Colors.amberAccent,
                  
                ),
                IconButton(
                  onPressed: () => context.go('/chat'), 
                  icon: Icon( Icons.message,size:40 ),
                  color: Colors.amberAccent,
                  
                ),
                IconButton(
                  onPressed: () => context.go('/petProfile'), 
                  icon: Icon( Icons.add_circle_outline,size:40 ),
                  color: Colors.amberAccent,
                  
                ),
                IconButton(
                  onPressed: () => context.go('/map'), 
                  icon: Icon( Icons.location_on,size:40 ),
                  color: Colors.amberAccent,
                  
                ),
                IconButton(
                  onPressed: () => context.go('/profile'), 
                  icon: Icon( Icons.person),
                  color: Colors.amberAccent,
                  
                ),
                
              ],
            ),
          ),
        ),

        // Two Heart Icons Below Card
        Positioned(
          bottom: 120,
          left: MediaQuery.of(context).size.width * 0.5 - 95,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: widget.onFavoriteToggle, // Make it interactive
                child: Icon(
                  Icons.heart_broken_outlined,
                  color: widget.isFavorite
                      ? Colors.amberAccent
                      : Colors.amberAccent, // Toggle favorite
                  size: 60,
                ),
              ),
              const SizedBox(width: 80), // Spacing between hearts
              GestureDetector(
                onTap: widget
                    .onFavoriteToggle, // Same functionality for second heart
                child: Icon(
                  Icons.favorite_border_outlined,
                  color: widget.isFavorite
                      ? Colors.amberAccent
                      : Colors.amberAccent,
                  size: 60,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
