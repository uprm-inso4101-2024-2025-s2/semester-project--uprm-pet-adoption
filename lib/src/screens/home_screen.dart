import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
// import 'package:semester_project__uprm_pet_adoption/src/widgets/bottom_nav_bar.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart'; // Import the PetCard widget

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          TextButton.icon(
            onPressed: () async {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) context.go('/auth');
            },
            icon: const Icon(Icons.logout),
            label: const Text('Log Out'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          const Text(
            "Available Pets",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),

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

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: () {
              context.go('/menu'); // Navigate to Menu screen
            },
            child: const Text('Go to Menu'),
          ),
        ],
      ),
      // bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
