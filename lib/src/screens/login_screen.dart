import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';

//This file contains the Authentication Screen class. Everything that shows up in the authentication screen is managed here.

class LogInScreen extends ConsumerWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      //AppBar is a prebuilt widget in Flutter
      appBar: AppBar(
          title: const
          Text('Log-In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Log-In Screen'),
            const SizedBox(
                height: 20
            ),
            //An elevated button is a label child displayed on a Material widget
            // whose Material.elevation increases when the button is pressed

            //Login button
            ElevatedButton(
              onPressed: () async {
                await ref.read(authProvider.notifier)
                .login(); // calls login function
                if (context.mounted) {
                  context.go('/'); // get user back to home screen after log in
                }
              },
              child: const Text('Log In'),
            ),

            //Go back to Auth button
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