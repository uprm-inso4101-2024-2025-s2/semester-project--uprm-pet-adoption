import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';

//This file contains the Authentication Screen class. Everything that shows up in the authentication screen is managed here.

class LogInScreen extends ConsumerWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //This section shows the background image for this screen
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'images/Login_SignUp_Background.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      
      child: Scaffold(
        //As scaffold makes is opaque by default set backgroundcolor to transaparent
        backgroundColor: Colors.transparent,
        //AppBar is a prebuilt widget in Flutter
        appBar: AppBar(
            toolbarHeight: -5,
            backgroundColor: Color(0xFF82B0FF),
            ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
               padding:
                    EdgeInsets.only(bottom: 250), // Adjust vertical positioning 
              child: const Text('log in',style: TextStyle(fontSize: 40, 
              fontWeight: FontWeight.w900, 
              fontFamily: 'Archivo')
              ),
              ),
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
      ),
    );
  }

}