import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_details.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';

import 'package:semester_project__uprm_pet_adoption/src/providers/match_logic.dart';

import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';
/// MatchMakingScreen:
/// Displays a placeholder layout for the future matching logic.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class PetStackNotifier extends StateNotifier<List<PetCard>> {
//   PetStackNotifier() : super(_initialPets());
//   static List<PetCard> _initialPets() => [
//     PetCard(

//       petName: "Ronnie",
//       petBreed: "Labrador",
//       petAge: "Puppy",
//       petImages: [
//         "assets/images/temp_dog_img.jpg",
//         "assets/images/temp_dog_img2.jpg",
//       ],
//       petDescription:
//       "My name is Ronnie and I am looking for a loving home!",
//       petTags: ["Labrador", "Puppy"],
//       isFavorite: false,
//       onFavoriteToggle: () {
//         print("Favorite toggled!");
//       },
//       onAdopt: () {
//         print("Adoption started!");
//       },
//       onAccept: () {
//         print("Pet Accepted!");
//       },
//       onReject: () {
//         print("Pet Rejected!");
//       },
//     ),
//     PetCard(
//       petName: "Luna",
//       petBreed: "Golden Retriever",
//       petAge: "Young Adult",
//       petImages: [
//         "assets/images/pet_placeholder.png",

//       ],
//       petDescription: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
//       petTags: ["Golden Retriever", "Young Adult"],
//       isFavorite: true,
//       onFavoriteToggle: () {
//         print("Luna favorite toggled!");
//       },
//       onAdopt: () {
//         print("Adoption started for Luna!");
//       },
//       onAccept: () {
//         print("Luna Accepted!");
//       },
//       onReject: () {
//         print("Luna Rejected!");
//       },
//     ),
//     PetCard(
//       petName: "Ronnie",
//       petBreed: "Labrador",
//       petAge: "Puppy",
//       petImages: [
//         "assets/images/temp_dog_img.jpg",
//         "assets/images/temp_dog_img2.jpg",
//       ],
//       petDescription: "My name is Ronnie and I am looking for a loving home!",
//       petTags: ["Labrador", "Puppy"],
//       isFavorite: false,
//       onFavoriteToggle: () {
//         print("Favorite toggled!");
//       },
//       onAdopt: () {
//         print("Adoption started!");
//       },
//       onAccept: () {
//         print("Pet Accepted!");
//       },
//       onReject: () {
//         print("Pet Rejected!");
//       },
//     ),
//     PetCard(
//       petName: "Luna",
//       petBreed: "Golden Retriever",
//       petAge: "Young Adult",
//       petImages: [
//         "assets/images/pet_placeholder.png",
//         "assets/images/temp_dog_img.jpg",
//       ],
//       petDescription: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
//       petTags: ["Golden Retriever", "Young Adult"],
//       isFavorite: true,
//       onFavoriteToggle: () {
//         print("Luna favorite toggled!");
//       },
//       onAdopt: () {
//         print("Adoption started for Luna!");
//       },
//       onAccept: () {
//         print("Luna Accepted!");
//       },
//       onReject: () {
//         print("Luna Rejected!");
//       },
//     ),
//   ];

//   void removeTopPet() {
//     if (state.isNotEmpty) {
//       state = [...state]..removeLast();
//     }
//   }

//   PetCard? get currentPet => state.isNotEmpty ? state.last : null;
// }

// final petStackProvider =
// StateNotifierProvider<PetStackNotifier, List<PetCard>>((ref) {
//   return PetStackNotifier();
// });
// final hasLoggedScreenViewProvider = StateProvider<bool>((ref) => false);


class MatchMakingScreen extends ConsumerWidget {
   MatchMakingScreen({super.key});
final petCardIndexProvider = StateNotifierProvider<MatchStackNotifier, List<PetCard>>((ref) => MatchStackNotifier());

  @override
  Widget build(BuildContext context, WidgetRef ref){
  final pets = ref.watch(petCardIndexProvider);
  final currentPet = ref.watch(petCardIndexProvider.notifier).currentPet;

 
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100), // Set desired height
        child: AppBar(
          backgroundColor: const Color.fromRGBO(130, 176, 255, 1),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end, // Align content to bottom
            children: [
                SizedBox(
                width: 200,
                height: 100, // final visible area
                child: Stack(
                  children: [
                    Positioned(
                      top: -25, // hide top 50px
                      left: 0,
                      child: Image.asset(
                        "assets/images/sign_log.png",
                        width: 200,
                        height: 150, // taller than visible area
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
                  ],
          ),
        ),
      ),
      body:SafeArea(
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
              // Middle content centered in remaining space
              Expanded(
                child: Center(
                  child: Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(10),
                    // color: Colors.white.withOpacity(0.4),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 15),
                        // AnimatedSwitcher to switch between cards
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200), // Slightly longer for visible animation
                          child: currentPet != null
                              ? GestureDetector(
                                  key: ValueKey(currentPet.petName),
                                  onTap: () {
                                  print(currentPet.petImages.first,);
                                  context.push('/petDetails', extra: {
                                  'petName': currentPet.petName,
                                  'petBreed': currentPet.petBreed,
                                  'petLocation': 'San Juan, PR',
                                  'petAge': currentPet.petAge,
                                  'petImage': currentPet.petImages.first,
                                  'petSex': 'Female',
                                  'petWeight': '15 lbs',
                                  'petHeight': '22 in',
                                  'petDistance': '3 miles',
                                  'isFavorite': currentPet.isFavorite,
                                  'onFavoriteToggle': currentPet.onFavoriteToggle,
                                  'onAdopt': currentPet.onAdopt,
                                });
                                },
                                  child: PetCard(
                                    petName: currentPet.petName,
                                    petBreed: currentPet.petBreed,
                                    petAge: currentPet.petAge,
                                    petImages: currentPet.petImages,
                                    petDescription: currentPet.petDescription,
                                    petTags: currentPet.petTags,
                                    isFavorite: currentPet.isFavorite,
                                    onFavoriteToggle: () {
                                      print("${currentPet.petName} favorite toggled: ${currentPet.isFavorite}");
                                      ref.invalidate(petCardIndexProvider);
                                    },
                                    onAdopt: () {
                                      print("Adoption started for ${currentPet.petName}!");
                                    },
                                    onAccept: () {
                                      print("${currentPet.petName} Accepted!");
                                      ref.read(petCardIndexProvider.notifier).removeTopPet(); // Correct
                                    },
                                    onReject: () {
                                      print("${currentPet.petName} Rejected!");
                                      ref.read(petCardIndexProvider.notifier).removeTopPet(); // Correct
                                    },

                                  ),
                                )
                              : const Text(
                                  "No more pets to show!",
                                  style: TextStyle(fontSize: 20),
                                ),
                        ),

                        const SizedBox(height: 30),
                        if (currentPet != null)
                            Positioned(
                              bottom: 120,
                              left: MediaQuery.of(context).size.width * 0.5 - 95,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      currentPet.onReject(); // reject = left heart
                                    },
                                    child: const Icon(
                                      Icons.heart_broken_outlined,
                                      color: Colors.amberAccent,
                                      size: 70,
                                    ),
                                  ),
                                  const SizedBox(width: 80),
                                  GestureDetector(
                                    onTap: () {
                                      currentPet.onAccept(); // accept = right heart
                                    },
                                    child: const Icon(
                                      Icons.favorite_border_outlined,
                                      color: Colors.amberAccent,
                                      size: 70,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                        // TextButton(
                        //   onPressed: () => context.go('/matchmaking'),
                        //   style: TextButton.styleFrom(
                        //     padding: EdgeInsets.zero,
                        //     backgroundColor: Colors.transparent,
                        //   ),
                        //   // child: Image.asset(
                        //   //   'assets/images/Find_Pawfect_Match_button.png',
                        //   //   width: 300,
                        //   //   height: 120,
                        //   //   fit: BoxFit.contain,
                        //   // ),
                        // ),
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
      
      // body: Stack(
      //   children: [
      //     // Background Image
      //     Positioned.fill(
      //       child: Image.asset(
      //         'assets/images/Login_SignUp_Background.png', // Make sure to add this image in your pubspec.yaml
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //     // Foreground content
      //     Center(
      //       child: TextButton(
      //         onPressed: () {
      //           context.go('/petProfile');
      //         },
      //         style: ButtonStyle(
      //           textStyle: MaterialStateProperty.all(
      //             const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //           ),
      //         ),
      //         child: const Text('Pet Profile Temp button'),
      //       ),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}
