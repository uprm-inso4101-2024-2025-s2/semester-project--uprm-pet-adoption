import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

//This file contains the Maps class. Everything that shows up in the map is managed here.

class Maps extends StatelessWidget {
  //Used Stateless widget since it is not required to change over tine.
  const Maps(
      {super.key}); //This is the class constructor. Calling this, allow access to the menu's properties

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //AppBar is a prebuilt widget in Flutter
      appBar: AppBar(title: const Text('Maps Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Map'),
            const SizedBox(height: 20),
            //An elevated button is a label child displayed on a Material widget
            // whose Material.elevation increases when the button is pressed
            ElevatedButton(
              onPressed: () {
                context.go('/'); // Navigate back to Home
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}