import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import for navigation

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Stack(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/map_backround.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Align(
          alignment: const Alignment(0, -2), // x=0 center, y=-0.2 moves it up
          child: Image.asset(
            'assets/images/aboutUs.png',
          ),
          ),
          Align(
            alignment: Alignment.bottomCenter, // optional spacing
              child: Image.asset(
                'assets/images/sign_log.png',
                width: 150,
                height: 150,
              ),
            ),
        ],
      ),
    );
  }
}
