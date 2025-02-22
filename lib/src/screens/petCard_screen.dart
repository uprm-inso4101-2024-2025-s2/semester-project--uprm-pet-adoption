import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';

/// PetCard Screen Widget
/// -----------------
/// This screen wraps `PetCard` and ensures that it always has the correct
/// background, layout, and styling. It dynamically displays pet information.
///
/// **Usage:**
/// - Use this screen whenever you want to display a `PetCard`.
/// - Pass dynamic pet details when navigating to this screen.
///
/// **Example Usage:**
///
/// ```dart
/// Navigator.push(
///   context,
///   MaterialPageRoute(
///     builder: (context) => PetScreen(
///       petName: "Firulai",
///       petBreed: "Golden Retriever",
///       petLocation: "San Juan, PR",
///       petAge: "2",
///       petImage: "images/pet_placeholder.png",
///       petSex: "Male",
///       petWeight: "7",
///       petHeight: "40",
///       petDistance: "2",
///       isFavorite: false,
///       onFavoriteToggle: () {},
///       onAdopt: () {},
///     ),
///   ),
/// );
/// ```
///
/// **Key Notes:**
/// - Do **not** use `PetCard` directly in other screens.
/// - Always wrap it inside `PetScreen` to maintain consistent styling.
/// - If modifications are needed, update this file instead of modifying `PetCard`.

class PetScreen extends StatelessWidget {
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

  const PetScreen({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'images/Login_SignUp_Background.png'), // Keep background
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: Center(
          child: PetCard(
            petName: petName,
            petBreed: petBreed,
            petLocation: petLocation,
            petAge: petAge,
            petImage: petImage,
            petSex: petSex,
            petWeight: petWeight,
            petHeight: petHeight,
            petDistance: petDistance,
            isFavorite: isFavorite,
            onFavoriteToggle: onFavoriteToggle,
            onAdopt: onAdopt,
          ),
        ),
      ),
    );
  }
}
