import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: AppBar(
          backgroundColor: Color(0xFFFFF581), // Updated background color
          title: Align(
            alignment: Alignment.centerLeft, // Align title to the left
            child: const Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Archivo',
                fontSize: 35,
              ),
            ),
          ),
          titleSpacing: 0, // Reduce spacing to move the title more to the left
          leading: IconButton(
            icon: Image.asset('assets/images/Arrow_Circle_dms.png',
                width: 30, height: 30),
            onPressed: () {
              context.go('/');
            },
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User Profile'),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
