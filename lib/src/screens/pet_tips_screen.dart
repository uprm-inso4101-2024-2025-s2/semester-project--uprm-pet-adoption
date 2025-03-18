import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
/// PetTips:
/// Displays a placeholder layout for the future petTips page.
class PetTips extends StatelessWidget {
  const PetTips({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar is a prebuilt widget in Flutter
      appBar: AppBar(title: const Text('Pet tips Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Pet Tips'),
            const SizedBox(height: 20),
            //An elevated button is a label child displayed on a Material widget
            // whose Material.elevation increases when the button is pressed
            ElevatedButton(
              onPressed: () {
                context.go('/'); // Navigate back to Home
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}