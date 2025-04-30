//Entry Point
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/preferences_screen.dart';
import 'preference_manager.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PreferenceManager(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Adoption',
      home: PreferencesScreen(), // Your screen that contains PetCards
    );
  }
}