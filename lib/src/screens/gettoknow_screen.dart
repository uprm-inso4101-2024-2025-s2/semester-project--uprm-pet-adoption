import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:go_router/go_router.dart'; // Import for navigation


class GettoknowScreen extends StatelessWidget {
  const GettoknowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AnalyticsService().logScreenView("gettoknow_screen");

    return Scaffold(
      appBar: AppBar(title: const Text("Get to Know")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Get to know us!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20), // Spacing between text and button
            ElevatedButton(
              onPressed: () {
                context.go('/auth'); // Return to the auth screen for the moment
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
