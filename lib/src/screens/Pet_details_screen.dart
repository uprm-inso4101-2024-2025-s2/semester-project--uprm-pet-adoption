import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_details.dart';

class PetDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> pet;

  const PetDetailsScreen({Key? key, required this.pet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PetDetails(
      petName: pet['petName'],
      petBreed: pet['petBreed'],
      petLocation: pet['petLocation'],
      petAge: pet['petAge'],
      petImage: pet['petImage'],
      petSex: pet['petSex'],
      petWeight: pet['petWeight'],
      petHeight: pet['petHeight'],
      petDistance: pet['petDistance'],
      isFavorite: pet['isFavorite'],
      onFavoriteToggle: pet['onFavoriteToggle'],
      onAdopt: pet['onAdopt'],
      // User-related properties
      petType: pet['petType'] ?? "Dog", // Adding default values if not available
      ageRange: pet['ageRange'] ?? "1-3 years", 
      size: pet['size'], // "Medium"
      energyLevel: pet['energyLevel'] ?? 0.0, // Default to 0 if not provided
      hasExperience: pet['hasExperience'] ?? true,
      hasOtherPets: pet['hasOtherPets'] ?? true,
      hasAllergies: pet['hasAllergies'] ?? false,
      livingSituation: pet['livingSituation'] ?? "Apartment",
      timeAvailable: pet['timeAvailable'] ?? 5.0,
      personality: pet['personality'] ?? "Friendly",
      specialCareOk: pet['specialCareOk'] ?? true,
      goodWithAnimals: pet['goodWithAnimals'] ?? true,
      goodWithKids: pet['goodWithKids'] ?? true,
    );
  }
}