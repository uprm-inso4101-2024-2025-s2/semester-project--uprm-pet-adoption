import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';

//This file contains the Authentication Screen class. Everything that shows up in the authentication screen is managed here.

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //AppBar is a prebuilt widget in Flutter
      appBar: AppBar(title: const Text('Pawfect Match')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome! Select an option to continue.'),
            const SizedBox(height: 20),

            //Log in button
            ElevatedButton(
              onPressed: () {
                context.go('/login');
              },
              child: const Text('log in'),
            ),

            //Sign up button
            ElevatedButton(
              onPressed: () {
                  context.go('/signup');
              },
              child: const Text('sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
