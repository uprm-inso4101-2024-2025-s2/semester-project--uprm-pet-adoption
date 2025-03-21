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
          backgroundColor: Color(0xFFFFF581),
          title: Align(
            alignment: Alignment.centerLeft,
            child: const Text(
              'Profile',
              style: TextStyle(
                fontFamily: 'Archivo',
                fontSize: 35,
              ),
            ),
          ),
          titleSpacing: 0,
          leading: IconButton(
            icon: Image.asset(
              'assets/images/Arrow_Circle_dms.png',
              width: 30,
              height: 30,
            ),
            onPressed: () {
              context.go('/');
            },
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Login_SignUp_Background.png', // Replace with your image path
              fit: BoxFit.cover, // Covers the entire background
            ),
          ),

          // Profile Image Above White Box
          Align(
            alignment: Alignment.topCenter, // Centers the image horizontally
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height *
                      0.3), // Adjust position
              child: CircleAvatar(
                radius: 60, // Adjust size
                backgroundImage: AssetImage(
                    'assets/images/Account_Circle_yellow_dms.png'), // Replace with your profile image path
              ),
            ),
          ),

          // White Box at the Bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.70, // Covers 70% of the screen
              width: double.infinity, // Full width
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30)), // Rounded top corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  'Username',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
