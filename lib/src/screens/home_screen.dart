import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/home_top_bar.dart';

//This file contains the Home Screen class. Everything that shows up in the home screen is managed here.

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //Header
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Set desired height
        child: TopNavBar(selectedIndex: 0), // Pass the current selected index
      ),

      body: Container(
        // Background
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Login_SignUp_Background.png'),
            fit: BoxFit.cover,
          ),
        ),

        // Main layout: Column with header, middle content, and footer
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Middle content
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // "Suggested Pet" placeholder
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  color: Colors.orangeAccent.withOpacity(0.4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Suggested Pet Placeholder",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      /// **Displays a pet card with swipe-based interaction**
                      ///
                      /// - Swiping **right** triggers `onAccept` (Pet is accepted).
                      /// - Swiping **left** triggers `onReject` (Pet is rejected).
                      /// - Clicking the heart icon toggles the **favorite status**.
                      /// - The card includes an **image carousel** for browsing pet pictures.
                      PetCard(
                        petName: "Ronnie",
                        petBreed: "Labrador",
                        petAge: "Puppy",
                        petImages: [
                          "assets/images/temp_dog_img.jpg",
                          "assets/images/temp_dog_img2.jpg",
                        ],
                        petDescription: "My name is Ronnie and I am looking for a loving home!",
                        petTags: ["Labrador", "Puppy"],
                        isFavorite: false,
                        onFavoriteToggle: () {
                          print("Favorite toggled!");
                        },
                        onAdopt: () {
                          print("Adoption started!");
                        },
                        onAccept: () {
                          print("Pet Accepted!");
                        },
                        onReject: () {
                          print("Pet Rejected!");
                        },
                      ),

                      const SizedBox(height: 30),

                // "Find Pawfect Match" button - navigates to match_making_screen.dart
                TextButton(
                  onPressed: () => context.go('/matchmaking'),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                  ),
                  child: Image.asset(
                    'assets/images/Find_Pawfect_Match_button.png',
                    width: 300, // Increase or decrease as needed
                    height: 120, // Increase or decrease as needed
                    fit: BoxFit.contain,
                  ),
                ),

                const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),

            // Footer
            Container(
              height: 60,
              width: double.infinity,
              color: Colors.white.withOpacity(0.8),
              alignment: Alignment.center,
              child: const Text(
                "Footer Placeholder",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
