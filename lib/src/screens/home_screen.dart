import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//This file contains the Home Screen class. Everything that shows up in the home screen is managed here.

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar is a prebuilt widget in Flutter
      appBar: AppBar(
          title: const Text('Home Screen')
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.go('/signin'); // Navigate to Sign-In screen
              },
              child: const Text('Go to Sign-In'),
            ),
            //An elevated button is a label child displayed on a Material widget whose Material.elevation
            // increases when the button is pressed
            ElevatedButton(
              onPressed: () {
                context.go('/menu'); // Navigate to Menu screen
              },
              child: const Text('Go to Menu'),
            ),
          ],
        ),
      ),
    );
  }
}


