import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:semester_project__uprm_pet_adoption/src/routes/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/match_logic.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MatchMaker.generateMatches(pets);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings =
      const Settings(persistenceEnabled: true);

  await Supabase.initialize(
    url: 'https://csrsmxmhiqwcalunugzf.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNzcnNteG1oaXF3Y2FsdW51Z3pmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDIyNjQxNDksImV4cCI6MjA1Nzg0MDE0OX0.em9xSkNRv462OXRm5pKDYEBqTqhMnPhEK5l5ttWw-94'
  );

  runApp(
    DevicePreview(
      enabled: true, // Set to false in production
      
      builder: (context) => ProviderScope(child: MyApp()),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      builder: DevicePreview.appBuilder, // Enables device preview
      debugShowCheckedModeBanner: false,
      title: 'Pet App',
      routerConfig: appRouter, // Navigation using GoRouter
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
