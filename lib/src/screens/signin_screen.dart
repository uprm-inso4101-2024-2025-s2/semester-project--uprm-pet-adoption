import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//This file contains the Authentication Screen class. Everything that shows up in the authentication screen is managed here.

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar is a prebuilt widget in Flutter
      appBar: AppBar(
          title: const
          Text('Sign-In')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Sign-In Screen'),
            const SizedBox(
                height: 20
            ),
            //An elevated button is a label child displayed on a Material widget
            // whose Material.elevation increases when the button is pressed

            //Sign in button
            ElevatedButton(
              onPressed: () {
                context.go('/menu'); // Navigate to Menu after sign-in
              },
              child: const Text('Sign In'),
            ),

            //Home screen button
            ElevatedButton(
              onPressed: () {
                context.go('/'); // Go back to Home
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }

}