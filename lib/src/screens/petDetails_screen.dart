import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_details.dart';

/// PetDetails Screen Widget
/// -----------------
/// This screen wraps `PetDetails` and ensures that it always has the correct
/// background, layout, and styling. It dynamically displays pet information.
///
/// **Usage:**
/// - Use this screen whenever you want to display a `PetDetails` widget.
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
/// - Do **not** use `PetDetails` directly in other screens.
/// - Always wrap it inside `PetScreen` to maintain consistent styling.
/// - If modifications are needed, update this file instead of modifying `PetDetails`.

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

// User-related variables (added from User class)
  final String? petType;
  final String? ageRange;
  final String? size;
  final double energyLevel;
  
  final bool? hasExperience;
  final bool? hasOtherPets;
  final bool? hasAllergies;
  final String? livingSituation;
  final double timeAvailable;
  
  final String? personality;
  final bool? specialCareOk;
  final bool? goodWithAnimals;
  final bool? goodWithKids;
  
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
    this.petType,
    this.ageRange,
    this.size,
    this.energyLevel = 0.0,
    this.hasExperience,
    this.hasOtherPets,
    this.hasAllergies,
    this.livingSituation,
    this.timeAvailable = 0.0,
    this.personality,
    this.specialCareOk,
    this.goodWithAnimals,
    this.goodWithKids,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/images/Login_SignUp_Background.png'), // Keep background
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
          child: PetDetails(
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
            
             // User-related properties
            petType: petType,
            ageRange: ageRange,
            size: size,
            energyLevel: energyLevel,
            hasExperience: hasExperience,
            hasOtherPets:hasOtherPets,
            hasAllergies: hasAllergies,
            livingSituation: livingSituation,
            timeAvailable: timeAvailable,
            personality: personality,
            specialCareOk: specialCareOk,
            goodWithAnimals: goodWithAnimals,
            goodWithKids: goodWithKids,
            
          ),
        ),
      ),
    );
  }
}
