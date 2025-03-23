import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/home_top_bar.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/home_top_bar.dart';

import 'menu_screen.dart';

//This file contains the Home Screen class. Everything that shows up in the home screen is managed here.
class PetStackNotifier extends StateNotifier<List<PetCard>> {
  PetStackNotifier() : super(_initialPets());
  static List<PetCard> _initialPets() => [
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
          PetCard(
            petName: "Luna",
            petBreed: "Golden Retriever",
            petAge: "Young Adult",
            petImages: [
              "assets/images/pet_placeholder.png",

            ],
            petDescription: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
            petTags: ["Golden Retriever", "Young Adult"],
            isFavorite: true,
            onFavoriteToggle: () {
              print("Luna favorite toggled!");
            },
            onAdopt: () {
              print("Adoption started for Luna!");
            },
            onAccept: () {
              print("Luna Accepted!");
            },
            onReject: () {
              print("Luna Rejected!");
            },
          ),
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
          PetCard(
            petName: "Luna",
            petBreed: "Golden Retriever",
            petAge: "Young Adult",
            petImages: [
              "assets/images/pet_placeholder.png",
              "assets/images/temp_dog_img.jpg",
            ],
            petDescription: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
            petTags: ["Golden Retriever", "Young Adult"],
            isFavorite: true,
            onFavoriteToggle: () {
              print("Luna favorite toggled!");
            },
            onAdopt: () {
              print("Adoption started for Luna!");
            },
            onAccept: () {
              print("Luna Accepted!");
            },
            onReject: () {
              print("Luna Rejected!");
            },
          ),
      ];

  void removeTopPet() {
    if (state.isNotEmpty) {
      state = [...state]..removeLast();
    }
  }

  PetCard? get currentPet => state.isNotEmpty ? state.last : null;
}

final petStackProvider =
    StateNotifierProvider<PetStackNotifier, List<PetCard>>((ref) {
  return PetStackNotifier();
});
final hasLoggedScreenViewProvider = StateProvider<bool>((ref) => false);
class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final petCardIndexProvider = StateProvider<int>((ref) => 0);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AnalyticsService().logScreenView("home_screen");

    final petList = ref.watch(petStackProvider);
    final currentPet = petList.isNotEmpty ? petList.last : null;
    return Scaffold(
      //Header
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80), // Set desired height
        child: TopNavBar(selectedIndex: 0,scaffoldKey: scaffoldKey,), // Pass the current selected index
      ),
      endDrawer: MenuScreen(),
      key: scaffoldKey,

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
                        duration: const Duration(milliseconds: 5),

                        child: currentPet != null
                            ? PetCard(
                                key: ValueKey(currentPet.petName), // 👈 THIS is important!
                                petName: currentPet.petName,
                                petBreed: currentPet.petBreed,
                                petAge: currentPet.petAge,
                                petImages: currentPet.petImages,
                                petDescription: currentPet.petDescription,
                                petTags: currentPet.petTags,
                                isFavorite: currentPet.isFavorite,
                                onFavoriteToggle: () {

                                  print("${currentPet.petName} favorite toggled: ${currentPet.isFavorite}");
                                  ref.invalidate(petCardIndexProvider); // Force rebuild if needed
                                },
                                onAdopt: () {
                                  print("Adoption started for ${currentPet.petName}!");
                                },
                                onAccept: () {

                                  print("${currentPet.petName} Accepted!");
                                  ref.read(petStackProvider.notifier).removeTopPet();



                                },
                                onReject: () {

                                  print("${currentPet.petName} Rejected!");

                                   ref.read(petStackProvider.notifier).removeTopPet();
                                   //ref.read(petCardIndexProvider.notifier).state++;


                                },
                              )
                            : const Text("No more pets to show!",style: TextStyle(fontSize: 20,),),
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





