import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';

//This file contains the SignUp Screen class. Everything that shows up in the sign up screen is managed here.

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //AppBar is a prebuilt widget in Flutter
      appBar: AppBar(title: const Text('Sign-Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign-up Screen'),
            const SizedBox(height: 20),
            //An elevated button is a label child displayed on a Material widget
            // whose Material.elevation increases when the button is pressed

            //Sign in button
            ElevatedButton(
              onPressed: () async {
                await ref.read(authProvider.notifier)
                .login(); // calls login function
                if (context.mounted) {
                  context.go('/'); // get user back to home screen after sign up
                }
              },
              child: const Text('Create account'),
            ),

            //Auth screen button
            ElevatedButton(
              onPressed: () {
                context.go('/auth'); // Go back to Auth screen
              },
              child: const Text('Return to Authentication'),
            ),
          ],
        ),
      ),
    );
  }
}
