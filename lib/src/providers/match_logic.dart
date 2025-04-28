
 import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_details.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';

import 'package:tuple/tuple.dart';


import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';
/// MatchMakingScreen:
/// Displays a placeholder layout for the future matching logic.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatchMaker {
  static List<PetCard> match = [];
  static List<PetCard> closeMatch = [];
  static List<PetCard> uncompatible = [];

  static void generateMatches(List<Tuple2<PetDetails, PetCard>> pets) {
    match.clear();
    closeMatch.clear();
    uncompatible.clear();

    int track = 0;
    for (var tuple in pets) {
      PetDetails details = tuple.item1;
      PetCard pet = tuple.item2;

      if (track % 2 == 0) {
        match.add(pet);
      } else {
        closeMatch.add(pet);
      }
      track++;
    }
  }
}

List<PetCard> match=[];
List<PetCard> close_match=[];
List<PetCard> uncompatible=[];
// List<Tuple2<PetDetails, PetCard>> pets = [];
// class PetStackNotifier extends StateNotifier<List<PetCard>> {
  // PetStackNotifier() : super(_initialPets());


List<Tuple2<PetDetails, PetCard>> pets = [
  Tuple2(
    PetDetails(
      petName: "Buddy",
      petBreed: "Golden Retriever",
      petLocation: "New York",
      petAge: "2 years",
      petImage: "assets/images/example_dogs/Buddy_golden_retiever.jpeg",
      petSex: "Male",
      petWeight: "30 kg",
      petHeight: "60 cm",
      petDistance: "5 km",
      isFavorite: false,
      onFavoriteToggle: () => print("Buddy Favorite toggled!"),
      onAdopt: () => print("Buddy Adoption started!"),
    ),
    PetCard(
      petName: "Buddy",
      petBreed: "Golden Retriever",
      petAge: "2 years",
      petImages: ["assets/images/example_dogs/Buddy_golden_retiever.jpeg"],
      petDescription: "Friendly golden retriever looking for a family.",
      petTags: ["Golden", "Friendly", "Dog"],
      isFavorite: false,
      onFavoriteToggle: () => print("Buddy Favorite toggled!"),
      onAdopt: () => print("Buddy Adoption started!"),
      onAccept: () => print("Buddy Accepted!"),
      onReject: () => print("Buddy Rejected!"),
    ),
  ),
  Tuple2(
    PetDetails(
      petName: "Luna",
      petBreed: "Siberian Husky",
      petLocation: "Chicago",
      petAge: "1 year",
      petImage: "assets/images/example_dogs/Luna_siberian_husky.jpg",
      petSex: "Female",
      petWeight: "22 kg",
      petHeight: "55 cm",
      petDistance: "8 km",
      isFavorite: false,
      onFavoriteToggle: () => print("Luna Favorite toggled!"),
      onAdopt: () => print("Luna Adoption started!"),
    ),
    PetCard(
      petName: "Luna",
      petBreed: "Siberian Husky",
      petAge: "1 year",
      petImages: ["assets/images/example_dogs/Luna_siberian_husky.jpg"],
      petDescription: "Energetic husky who loves snow and fun!",
      petTags: ["Husky", "Energetic", "Dog"],
      isFavorite: false,
      onFavoriteToggle: () => print("Luna Favorite toggled!"),
      onAdopt: () => print("Luna Adoption started!"),
      onAccept: () => print("Luna Accepted!"),
      onReject: () => print("Luna Rejected!"),
    ),
  ),
  Tuple2(
    PetDetails(
      petName: "Milo",
      petBreed: "Beagle",
      petLocation: "San Francisco",
      petAge: "3 years",
      petImage: "assets/images/example_dogs/Milo_beagle.jpg",
      petSex: "Male",
      petWeight: "12 kg",
      petHeight: "40 cm",
      petDistance: "2 km",
      isFavorite: false,
      onFavoriteToggle: () => print("Milo Favorite toggled!"),
      onAdopt: () => print("Milo Adoption started!"),
    ),
    PetCard(
      petName: "Milo",
      petBreed: "Beagle",
      petAge: "3 years",
      petImages: ["assets/images/example_dogs/Milo_beagle.jpg"],
      petDescription: "Happy little beagle full of energy!",
      petTags: ["Beagle", "Happy", "Dog"],
      isFavorite: false,
      onFavoriteToggle: () => print("Milo Favorite toggled!"),
      onAdopt: () => print("Milo Adoption started!"),
      onAccept: () => print("Milo Accepted!"),
      onReject: () => print("Milo Rejected!"),
    ),
  ),
  Tuple2(
    PetDetails(
      petName: "Chloe",
      petBreed: "British Shorthair",
      petLocation: "Austin",
      petAge: "4 years",
      petImage: "assets/images/example_dogs/Chloe_british_shorthair.jpg",
      petSex: "Female",
      petWeight: "6 kg",
      petHeight: "30 cm",
      petDistance: "6 km",
      isFavorite: false,
      onFavoriteToggle: () => print("Chloe Favorite toggled!"),
      onAdopt: () => print("Chloe Adoption started!"),
    ),
    PetCard(
      petName: "Chloe",
      petBreed: "British Shorthair",
      petAge: "4 years",
      petImages: ["assets/images/example_dogs/Chloe_british_shorthair.jpg"],
      petDescription: "Lazy and adorable British cat.",
      petTags: ["Cat", "Cute", "Lazy"],
      isFavorite: false,
      onFavoriteToggle: () => print("Chloe Favorite toggled!"),
      onAdopt: () => print("Chloe Adoption started!"),
      onAccept: () => print("Chloe Accepted!"),
      onReject: () => print("Chloe Rejected!"),
    ),
  ),
  Tuple2(
    PetDetails(
      petName: "Simba",
      petBreed: "Maine Coon",
      petLocation: "Seattle",
      petAge: "2 years",
      petImage: "assets/images/example_dogs/Simba_maine_coon.jpg",
      petSex: "Male",
      petWeight: "8 kg",
      petHeight: "35 cm",
      petDistance: "3 km",
      isFavorite: false,
      onFavoriteToggle: () => print("Simba Favorite toggled!"),
      onAdopt: () => print("Simba Adoption started!"),
    ),
    PetCard(
      petName: "Simba",
      petBreed: "Maine Coon",
      petAge: "2 years",
      petImages: ["assets/images/example_dogs/Simba_maine_coon.jpg"],
      petDescription: "Big fluffy Maine Coon ready to cuddle.",
      petTags: ["Cat", "Fluffy", "Gentle"],
      isFavorite: false,
      onFavoriteToggle: () => print("Simba Favorite toggled!"),
      onAdopt: () => print("Simba Adoption started!"),
      onAccept: () => print("Simba Accepted!"),
      onReject: () => print("Simba Rejected!"),
    ),
  ),
  Tuple2(
    PetDetails(
      petName: "Max",
      petBreed: "Boxer",
      petLocation: "Los Angeles",
      petAge: "5 years",
      petImage: "assets/images/example_dogs/Max_boxer.jpeg",
      petSex: "Male",
      petWeight: "28 kg",
      petHeight: "58 cm",
      petDistance: "7 km",
      isFavorite: false,
      onFavoriteToggle: () => print("Max Favorite toggled!"),
      onAdopt: () => print("Max Adoption started!"),
    ),
    PetCard(
      petName: "Max",
      petBreed: "Boxer",
      petAge: "5 years",
      petImages: ["assets/images/example_dogs/Max_boxer.jpeg"],
      petDescription: "Strong loyal companion for active families.",
      petTags: ["Dog", "Boxer", "Strong"],
      isFavorite: false,
      onFavoriteToggle: () => print("Max Favorite toggled!"),
      onAdopt: () => print("Max Adoption started!"),
      onAccept: () => print("Max Accepted!"),
      onReject: () => print("Max Rejected!"),
    ),
  ),
  Tuple2(
    PetDetails(
      petName: "Misty",
      petBreed: "Persian Cat",
      petLocation: "Miami",
      petAge: "3 years",
      petImage: "assets/images/example_dogs/Misty_persian_cat.jpg",
      petSex: "Female",
      petWeight: "5 kg",
      petHeight: "25 cm",
      petDistance: "4 km",
      isFavorite: false,
      onFavoriteToggle: () => print("Misty Favorite toggled!"),
      onAdopt: () => print("Misty Adoption started!"),
    ),
    PetCard(
      petName: "Misty",
      petBreed: "Persian",
      petAge: "3 years",
      petImages: ["assets/images/example_dogs/Misty_persian_cat.jpg"],
      petDescription: "Beautiful Persian cat looking for love.",
      petTags: ["Persian", "Cat", "Elegant"],
      isFavorite: false,
      onFavoriteToggle: () => print("Misty Favorite toggled!"),
      onAdopt: () => print("Misty Adoption started!"),
      onAccept: () => print("Misty Accepted!"),
      onReject: () => print("Misty Rejected!"),
    ),
  ),
  Tuple2(
    PetDetails(
      petName: "Charlie",
      petBreed: "French Bulldog",
      petLocation: "Boston",
      petAge: "2 years",
      petImage: "assets/images/example_dogs/Charlie_french_bulldog.jpg",
      petSex: "Male",
      petWeight: "11 kg",
      petHeight: "30 cm",
      petDistance: "1 km",
      isFavorite: false,
      onFavoriteToggle: () => print("Charlie Favorite toggled!"),
      onAdopt: () => print("Charlie Adoption started!"),
    ),
    PetCard(
      petName: "Charlie",
      petBreed: "French Bulldog",
      petAge: "2 years",
      petImages: ["assets/images/example_dogs/Charlie_french_bulldog.jpg"],
      petDescription: "Charming French Bulldog ready to melt hearts.",
      petTags: ["Frenchie", "Cute", "Dog"],
      isFavorite: false,
      onFavoriteToggle: () => print("Charlie Favorite toggled!"),
      onAdopt: () => print("Charlie Adoption started!"),
      onAccept: () => print("Charlie Accepted!"),
      onReject: () => print("Charlie Rejected!"),
    ),
  ),
  Tuple2(
    PetDetails(
      petName: "Coco",
      petBreed: "Poodle",
      petLocation: "Dallas",
      petAge: "1 year",
      petImage: "assets/images/example_dogs/coco_poodle.jpg",
      petSex: "Female",
      petWeight: "7 kg",
      petHeight: "35 cm",
      petDistance: "2 km",
      isFavorite: false,
      onFavoriteToggle: () => print("Coco Favorite toggled!"),
      onAdopt: () => print("Coco Adoption started!"),
    ),
    PetCard(
      petName: "Coco",
      petBreed: "Poodle",
      petAge: "1 year",
      petImages: ["assets/images/example_dogs/coco_poodle.jpg"],
      petDescription: "Playful poodle who loves cuddles.",
      petTags: ["Poodle", "Smart", "Dog"],
      isFavorite: false,
      onFavoriteToggle: () => print("Coco Favorite toggled!"),
      onAdopt: () => print("Coco Adoption started!"),
      onAccept: () => print("Coco Accepted!"),
      onReject: () => print("Coco Rejected!"),
    ),
  ),
];

class MatchStackNotifier extends StateNotifier<List<PetCard>> {
  MatchStackNotifier() : super(MatchMaker.match);

  void removeTopPet() {
    if (state.isNotEmpty) {
      state = [...state]..removeLast();
    }
  }

  PetCard? get currentPet => state.isNotEmpty ? state.last : null;
}

// Where MatchMaker is

class CloseMatchStackNotifier extends StateNotifier<List<PetCard>> {
  CloseMatchStackNotifier() : super(MatchMaker.closeMatch);

  void removeTopPet() {
    if (state.isNotEmpty) {
      state = [...state]..removeLast();
    }
  }

  PetCard? get currentPet => state.isNotEmpty ? state.last : null;
}


// void match_making_logic(){
//   // List<PetCard> match=[];
//   // List<PetCard> close_match=[];
//   // List<PetCard> uncompatible;
//   int track=0;
//   for (var tuple in pets){
//     int count=0;
//     PetDetails details = tuple.item1;
//     PetCard pet = tuple.item2;
//     if (track%2==0){
//       match.add(pet);
//     }else{
//       close_match.add(pet);
//     }
//     track++;
//     // if (user.pet==pet.pet){
//     //     count+=1;
//     // }
//     // if (pet.petAge==user.petAge){
//     //     count+=1;
//     // }

//   }
//   // return match;
//   print(match);
//   print('');
//   print(close_match);
// }

// @override
// void initState() {
//   initState();
//   match_making_logic(); // <-- called when screen loads
// }
// // }