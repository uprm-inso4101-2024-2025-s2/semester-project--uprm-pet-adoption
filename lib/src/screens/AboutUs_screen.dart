import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import for navigation

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About Us")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Info on Us!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Spacing between text and button
            ElevatedButton(
              onPressed: () {
                context.go('/menu'); // Return to the auth screen for the moment
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
