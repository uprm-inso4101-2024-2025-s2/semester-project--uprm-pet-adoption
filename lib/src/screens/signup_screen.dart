import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        //AppBar is a prebuilt widget in Flutter
        appBar: AppBar(
            toolbarHeight: -5,
            backgroundColor: Color(0xFF82B0FF),
        ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/Login_SignUp_Background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Sign-Up Form
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'sign up',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Archivo',
                        color: Color.fromARGB(255, 0, 0, 0), // Improved contrast
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.85,
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
                      children: [
                        buildTextField(
                            label: "Email",
                            icon: Icons.email,
                            obscureText: false),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: buildTextField(
                                  label: "First Name", obscureText: false),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: buildTextField(
                                  label: "Last Name", obscureText: false),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        buildTextField(
                            label: "Password",
                            icon: Icons.lock_outline,
                            obscureText: true),
                        const SizedBox(height: 20),
                        buildTextField(
                            label: "Confirm Password",
                            icon: Icons.lock_outline,
                            obscureText: true),
                        const SizedBox(height: 25),
                        buildButton(
                          text: "Create Account",
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  buildButton(
                    text: "Return",
                    onPressed: () => context.go('/auth'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(
      {required String label, IconData? icon, required bool obscureText}) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 3.0),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        ),
        labelText: label,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: 'Archivo',
          color: Colors.black,
        ),
        suffixIcon: icon != null ? Icon(icon, color: Color(0xFF5D5793)) : null,
      ),
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        fontFamily: 'Archivo',
        color: Colors.black,
      ),
    );
  }

  Widget buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC8E8FF),
        foregroundColor: Colors.black,
        minimumSize: const Size(200, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Archivo',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
