//Entry Point
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/routes/app_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/preferences_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/preference_manager.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize preferences when app starts
    ref.read(preferenceManagerProvider.notifier).loadPreferences();
    
    return MaterialApp.router(
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      title: 'Pet App',
      routerConfig: appRouter,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}