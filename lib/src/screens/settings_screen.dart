import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import for navigation

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "App Settings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Spacing between text and button
            ElevatedButton(
              onPressed: () {
                context.go('/menu'); // Return to the menu screen for the moment
              },
              child: const Text("Return"),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.go('/chat'); // Go to chat screen
              },
              child: const Text("Message"),
            ),
          ],
        ),
      ),
    );
  }
}