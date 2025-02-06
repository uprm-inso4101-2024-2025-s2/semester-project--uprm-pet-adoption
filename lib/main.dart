import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/src/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pet App',
      routerConfig: appRouter,  // Use GoRouter for navigation
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}