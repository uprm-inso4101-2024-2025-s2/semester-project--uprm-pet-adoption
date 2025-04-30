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
    );
  }
}