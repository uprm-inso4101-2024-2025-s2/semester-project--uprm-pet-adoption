import 'dart:ui';
import 'dart:math';


import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_details.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';
import 'package:confetti/confetti.dart';


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


class MatchMakingScreen extends ConsumerStatefulWidget {
  MatchMakingScreen({super.key});

  @override
  ConsumerState<MatchMakingScreen> createState() => _MatchMakingScreenState();
}

class _MatchMakingScreenState extends ConsumerState<MatchMakingScreen> {
  final petCardIndexProvider =
      StateNotifierProvider<MatchStackNotifier, List<PetCard>>((ref) => MatchStackNotifier());

  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController = ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pets = ref.watch(petCardIndexProvider);
    final currentPet = ref.watch(petCardIndexProvider.notifier).currentPet;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(130, 176, 255, 1),
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 200,
                height: 100,
                child: Stack(
                  children: [
                    Positioned(
                      top: -25,
                      left: 0,
                      child: Image.asset(
                        "assets/images/sign_log.png",
                        width: 200,
                        height: 150,
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
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Login_SignUp_Background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 15),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 200),
                              child: currentPet != null
                                  ? GestureDetector(
                                      key: ValueKey(currentPet.petName),
                                      onTap: () {
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
                                          ref.invalidate(petCardIndexProvider);
                                        },
                                        onAdopt: () {
                                          print("Adoption started for \${currentPet.petName}!");
                                        },
                                        onAccept: () {
                                          print("\${currentPet.petName} Accepted!");
                                          _confettiController.play();
                                          ref.read(petCardIndexProvider.notifier).removeTopPet();
                                        },
                                        onReject: () {
                                          print("\${currentPet.petName} Rejected!");
                                          ref.read(petCardIndexProvider.notifier).removeTopPet();
                                        },
                                      ),
                                    )
                                  : const Text("No more pets to show!", style: TextStyle(fontSize: 20)),
                            ),
                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Confetti animation centered with the PetCard
            Positioned(
            bottom: 600,
            left: 10,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: -pi / 2,
              blastDirectionality: BlastDirectionality.directional,
              emissionFrequency: 0.05,
              numberOfParticles: 20,
              gravity: 0.3,
              minBlastForce: 5,
              maxBlastForce: 10,
              colors: const [
                Colors.red,
                Colors.blue,
                Colors.green,
                Colors.orange,
                Colors.purple,
              ],
            ),
          ),

            // Accept / Reject buttons centered under the PetCard
            if (currentPet != null)
              Positioned(
                bottom: 50,
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
          ],
        ),
      ),
      bottomNavigationBar: const BottomNavBar(selectedIndex: 0),
    );
  }
}