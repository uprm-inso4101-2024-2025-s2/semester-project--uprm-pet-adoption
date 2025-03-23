import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';

//This file contains the Authentication Screen class. Everything that shows up in the authentication screen is managed here.
final hasLoggedAuthScreenViewProvider = StateProvider<bool>((ref) => false);

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLoggedScreenView = ref.watch(hasLoggedAuthScreenViewProvider);
    if (!hasLoggedScreenView) {
      AnalyticsService().logScreenView("auth_screen");
      ref.read(hasLoggedAuthScreenViewProvider.notifier).state = true;
    }

    return Scaffold(
      backgroundColor: Color(0xFF82B0FF),
      body: Column(
        children: [
          const SizedBox(height: 5),
          const SizedBox(
            height: 350,
            child: Image(image: AssetImage('assets/images/sign_log.png')),
          ), // Controls text position
          const Text('Welcome! Select an option to continue.'), // welcome text
          const SizedBox(height: 20),

          Expanded(
            flex: 0, // Controls how much space there is between buttons and "welcome text"
            child: Container(), // Empty space to push buttons lower
          ),

          // Sign up button
          TextButton(
            onPressed: () {
              context.go('/signup');
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
            ),
            child: const Image(image: AssetImage('assets/images/SignUpbutton.png')),
          ),

          const SizedBox(height: 15), // Adjust space between buttons

          // Log in button
          TextButton(
            onPressed: () {
              context.go('/login');
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              backgroundColor: Colors.transparent,
            ),
            child: const Image(image: AssetImage('assets/images/LogInbutton.png')),
          ),
        ],
      ),
    );
  }
}

