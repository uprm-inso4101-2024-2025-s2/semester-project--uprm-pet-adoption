import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/profile_header.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          backgroundColor: Color(0xFFFFF581), // Updated background color
          title: const Text(
            'Profile',
            style: TextStyle(
              fontFamily: 'Archivo',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: Image.asset('assets/images/Arrow_Circle_dms.png',
                width: 30, height: 30), // Fixed missing height
            onPressed: () {
              context.go('/home');
            },
          ),
          actions: [
            IconButton(
              icon: Image.asset('assets/images/filters.png',
                  width: 60, height: 60), // Notification as image
              onPressed: () {
                context.go('/notifications');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User Profile'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/');
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
