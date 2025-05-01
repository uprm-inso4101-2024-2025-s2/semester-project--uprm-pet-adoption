import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/favorite_pet_cards_provider.dart';

class PetFavoriteScreen extends ConsumerWidget {
  const PetFavoriteScreen({super.key});

  Widget _heartPawIcon(
    String imagePath, {
    double heartSize = 42,
    double pawWidth = 22,
    double pawHeight = 22,
    double topPadding = 0,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.favorite, color: Color.fromRGBO(255, 245, 121, 1.0), size: heartSize),
          SizedBox(
            width: heartSize,
            height: heartSize,
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                imagePath,
                width: pawWidth,
                height: pawHeight,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteCards = ref.watch(favoritePetCardsProvider);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF82B0FF),
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              if (Navigator.canPop(context)) {
                context.pop();
              } else {
                context.go('/');
              }
            },
          ),
          title: Row(
            children: [
              _heartPawIcon('assets/images/cat_paw.png', heartSize: 44, pawWidth: 18, pawHeight: 18, topPadding: 6),
              const SizedBox(width: 6),
              const Text(
                'Favorite Pets',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Archivo',
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 6),
              _heartPawIcon('assets/images/dog_paw.png', heartSize: 44, pawWidth: 29, pawHeight: 29, topPadding: 6),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                children: const [
                  Text("Filters", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(width: 4),
                  Icon(Icons.filter_alt, color: Colors.black),
                  Spacer(),
                  Text("Edit", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                  SizedBox(width: 4),
                  Icon(Icons.edit, size: 20, color: Colors.black),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/Login_SignUp_Background.png'),
            fit: BoxFit.cover,
            repeat: ImageRepeat.repeat,
          ),
        ),
        child: favoriteCards.isEmpty
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 245, 121, 1.0),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Paw No!', style: TextStyle(fontWeight: FontWeight.w900, fontFamily: 'Archivo', fontSize: 28, color: Colors.black)),
                        SizedBox(height: 16),
                        Text("You haven’t favorited any pets yet.", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Archivo', color: Colors.black)),
                        SizedBox(height: 16),
                        Text("Go find your Pawfect Match!", textAlign: TextAlign.center, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Archivo', color: Colors.black)),
                      ],
                    ),
                  ),
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: favoriteCards.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final pet = favoriteCards[index];
                  final isStillFavorite = ref.watch(favoritePetCardsProvider)
                      .any((fav) => fav.petImages.first == pet.petImages.first);

                  return Container(
                    key: ValueKey(pet.petImages.first),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black38, width: 1),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            pet.petImages.first,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 10,
                          right: 10,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.yellow.shade300,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              pet.petName,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                fontFamily: 'Archivo',
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              ref.read(favoritePetCardsProvider.notifier).toggleFavorite(pet);
                            },
                            child: Icon(
                              isStillFavorite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.redAccent,
                              size: 28,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
