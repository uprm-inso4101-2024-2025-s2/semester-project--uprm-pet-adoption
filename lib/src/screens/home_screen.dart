import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';

//This file contains the Home Screen class. Everything that shows up in the home screen is managed here.

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Container(
        // Background
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/Login_SignUp_Background.png'),
            fit: BoxFit.cover,
          ),
        ),

        // Main layout: Column with header, middle content, and footer
        child: Column(
          children: [
            // Header
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.white.withOpacity(0.8),
              alignment: Alignment.center,
              child: const Text(
                "Header Placeholder",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Middle content centered in remaining space
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(10),
                  color: Colors.orangeAccent.withOpacity(0.4),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        "Suggested Pet Placeholder",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15),
                      PetCard(
                        petName: "Ronnie",
                        petBreed: "Labrador",
                        petAge: "Puppy",
                        petImages: [
                          "assets/images/temp_dog_img.jpg",
                          "assets/images/temp_dog_img2.jpg",
                        ],
                        petDescription:
                            "My name is Ronnie and I am looking for a loving home!",
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
                      TextButton(
                        onPressed: () => context.go('/matchmaking'),
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                        ),
                        child: Image.asset(
                          'assets/images/Find_Pawfect_Match_button.png',
                          width: 300,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
            

        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),

    );
  }
}
