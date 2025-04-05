import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// MatchMakingScreen:
/// Displays a placeholder layout for the future matching logic.
class MatchMakingScreen extends StatelessWidget {
  const MatchMakingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Screen title
        title: const Text("Match Making"),
        backgroundColor: Color(0xFF82B0FF),
      ),

      // Placeholder body for future matching content
      body: Center(
        child: TextButton(
          onPressed: (){ context.go('/petProfile');},
          style: ButtonStyle(textStyle: MaterialStateProperty.all(TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          child: Text('Pet Profile Temp button'),
        ),
      ),
    );
  }
}
