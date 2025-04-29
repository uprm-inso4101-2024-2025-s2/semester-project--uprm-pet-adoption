import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PetFavoriteScreen extends StatelessWidget {
  const PetFavoriteScreen({super.key});

  // 🐾 Heart + Paw Icon Widget with optional vertical padding
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(95),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF82B0FF),
          elevation: 0,
          centerTitle: false,
          titleSpacing: 0, // Align flush to the left
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
              _heartPawIcon(
                'assets/images/cat_paw.png',
                heartSize: 44,
                pawWidth: 18,
                pawHeight: 18,
                topPadding: 6,
              ),
              const SizedBox(width: 6),
              const Text(
                'Pet Favorites',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Archivo',
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(width: 6),
              _heartPawIcon(
                'assets/images/dog_paw.png',
                heartSize: 44,
                pawWidth: 29,
                pawHeight: 29,
                topPadding: 6,
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Filters",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.filter_alt, color: Colors.black),
                  const Spacer(),
                  Row(
                    children: const [
                      Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.edit,
                        size: 20,
                        color: Colors.black,
                      ),
                    ],
                  ),
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
        child: Column(
          children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(255, 245, 121, 1.0),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Paw No!',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Archivo',
                        fontSize: 28,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "You haven’t favorited any pets yet.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Go find your Pawfect Match!",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
