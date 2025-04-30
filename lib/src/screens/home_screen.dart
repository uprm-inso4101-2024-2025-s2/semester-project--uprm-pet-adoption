import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/home_top_bar.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/favorite_pet_cards_provider.dart';

import 'menu_screen.dart';

class PetStackNotifier extends StateNotifier<List<PetCard>> {
  PetStackNotifier()
      : super([
          _buildPetCard(
            name: "Ronnie",
            breed: "Labrador",
            age: "Puppy",
            images: [
              "assets/images/temp_dog_img.jpg",
              "assets/images/temp_dog_img2.jpg",
            ],
            description: "My name is Ronnie and I am looking for a loving home!",
            tags: ["Labrador", "Puppy"],
          ),
          _buildPetCard(
            name: "Luna",
            breed: "Golden Retriever",
            age: "Young Adult",
            images: [
              "assets/images/pet_placeholder.png",
            ],
            description: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
            tags: ["Golden Retriever", "Young Adult"],
            isFavoriteDefault: true,
          ),
          _buildPetCard(
            name: "Ronnie",
            breed: "Labrador",
            age: "Puppy",
            images: [
              "assets/images/temp_dog_img.jpg",
              "assets/images/temp_dog_img2.jpg",
            ],
            description: "My name is Ronnie and I am looking for a loving home!",
            tags: ["Labrador", "Puppy"],
          ),
          _buildPetCard(
            name: "Luna",
            breed: "Golden Retriever",
            age: "Young Adult",
            images: [
              "assets/images/pet_placeholder.png",
              "assets/images/temp_dog_img.jpg",
            ],
            description: "Hi, I'm Luna! I'm a playful and friendly dog who loves belly rubs.",
            tags: ["Golden Retriever", "Young Adult"],
            isFavoriteDefault: true,
          ),
        ]);

  void removeTopPet() {
    if (state.isNotEmpty) {
      state = [...state]..removeLast();
    }
  }

  PetCard? get currentPet => state.isNotEmpty ? state.last : null;
}

PetCard _buildPetCard({
  required String name,
  required String breed,
  required String age,
  required List<String> images,
  required String description,
  required List<String> tags,
  bool isFavoriteDefault = false,
}) {
  return PetCard(
    petName: name,
    petBreed: breed,
    petAge: age,
    petImages: images,
    petDescription: description,
    petTags: tags,
    isFavorite: isFavoriteDefault,
    onFavoriteToggle: () {}, // dynamically replaced in build
    onAdopt: () {
      print("Adoption started for $name!");
    },
    onAccept: () {
      print("$name Accepted!");
    },
    onReject: () {
      print("$name Rejected!");
    },
  );
}

final petStackProvider =
    StateNotifierProvider<PetStackNotifier, List<PetCard>>((ref) {
  return PetStackNotifier();
});

final hasLoggedScreenViewProvider = StateProvider<bool>((ref) => false);

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AnalyticsService().logScreenView("home_screen");

    final petList = ref.watch(petStackProvider);
    final currentPet = petList.isNotEmpty ? petList.last : null;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: TopNavBar(selectedIndex: 0, scaffoldKey: scaffoldKey),
      ),
      endDrawer: MenuScreen(),
      key: scaffoldKey,
      body: SafeArea(
        child: Container(
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
                          duration: const Duration(milliseconds: 300),
                          child: currentPet != null
                              ? PetCard(
                                  key: ValueKey(currentPet.petImages.first),
                                  petName: currentPet.petName,
                                  petBreed: currentPet.petBreed,
                                  petAge: currentPet.petAge,
                                  petImages: currentPet.petImages,
                                  petDescription: currentPet.petDescription,
                                  petTags: currentPet.petTags,
                                  isFavorite: ref
                                      .watch(favoritePetCardsProvider)
                                      .contains(currentPet),
                                  onFavoriteToggle: () {
                                    ref
                                        .read(favoritePetCardsProvider.notifier)
                                        .toggleFavorite(currentPet);
                                  },
                                  onAdopt: currentPet.onAdopt,
                                  onAccept: () {
                                    currentPet.onAccept();
                                    ref
                                        .read(petStackProvider.notifier)
                                        .removeTopPet();
                                  },
                                  onReject: () {
                                    currentPet.onReject();
                                    ref
                                        .read(petStackProvider.notifier)
                                        .removeTopPet();
                                  },
                                )
                              : const Text(
                                  "No more pets to show!",
                                  style: TextStyle(fontSize: 20),
                                ),
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
