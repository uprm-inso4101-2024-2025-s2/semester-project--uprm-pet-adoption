import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import for navigation

/// A screen that presents "About Us" information, including a background map,
/// a central image, and a bottom-aligned logo.
class AboutUsScreen extends StatelessWidget {
  /// Creates an instance of [AboutUsScreen].
  const AboutUsScreen({super.key});

  /// Builds the widget tree for the About Us screen.
  ///
  /// The screen is composed of:
  /// 1. An [AppBar] with custom navigation and styling.
  /// 2. A [Stack] body layering:
  ///    - A full-screen background image.
  ///    - A centered illustration slightly above the vertical center.
  ///    - A bottom-centered logo.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Top app bar with custom back/menu button and title
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF581),
        leading: IconButton(
          icon: Image.asset(
            'assets/images/Arrow_Circle_dms.png',
            width: 40,
            height: 40,
          ),
          onPressed: () => context.go('/?openMenu=true'),
        ),
        title: const Text(
          'About Us',
          style: TextStyle(
            fontFamily: 'Archivo',
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        titleSpacing: 0,
      ),

      // Body uses a Stack to layer multiple images
      body: Stack(
        fit: StackFit.expand,
        children: [
          /// Full-screen background image covering the entire body
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/map_backround.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          /// Illustration positioned slightly above the center of the screen
          Align(
            alignment: const Alignment(0, -2),
            child: Image.asset(
              'assets/images/aboutUs.png',
            ),
          ),

          /// Logo or signature aligned at the bottom center of the screen
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Image.asset(
                'assets/images/sign_log.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
