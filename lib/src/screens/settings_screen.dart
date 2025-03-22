import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings Screen')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min, // Ensures Column only takes necessary space
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/'); // Ensure correct route
              },
              child: const Text('Dev Button to go back to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
