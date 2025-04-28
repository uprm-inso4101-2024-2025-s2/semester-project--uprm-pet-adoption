import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';

// Loading Screen class
class LoadingScreen extends ConsumerStatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

// State for the Loading Screen
class _LoadingScreenState extends ConsumerState<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    AnalyticsService().logScreenView("loading_screen");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // Same background image as the other screens for consistency and
        // smooth transitions between screens
        image: DecorationImage(
          image: AssetImage('assets/images/Login_SignUp_Background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          toolbarHeight: -5,
          backgroundColor: const Color(0xFF82B0FF),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  'Loading',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Archivo',
                  ),
                ),
              ),
              Container(
                height: 300,
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // Circular progress indicator
                    CircularProgressIndicator(
                      color: Color(0xFF5D5793),
                      strokeWidth: 5,
                    ),
                    SizedBox(height: 30),
                    Text(
                      'Please wait...',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}