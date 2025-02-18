import 'package:flutter/material.dart';
import 'package:semester_project__uprm_pet_adoption/src/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Pet App',
      routerConfig: appRouter, // Use GoRouter for navigation
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
