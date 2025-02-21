import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';

class SignUpScreen extends ConsumerWidget {
  SignUpScreen({super.key});

  // Controllers for handling text input
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

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
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Sign Up Title
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Archivo',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // Form Container
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
                        // Email Text Field
                        buildTextField(controller: emailController, label: "Email", icon: Icons.email, obscureText: false),
                        const SizedBox(height: 20),
                        // First and Last Name Fields
                        Row(
                          children: [
                            Expanded(child: buildTextField(controller: firstNameController, label: "First Name", obscureText: false)),
                            const SizedBox(width: 10),
                            Expanded(child: buildTextField(controller: lastNameController, label: "Last Name", obscureText: false)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        // Password and Confirm Password Fields
                        buildTextField(controller: passwordController, label: "Password", icon: Icons.lock_outline, obscureText: true),
                        const SizedBox(height: 20),
                        buildTextField(controller: confirmPasswordController, label: "Confirm Password", icon: Icons.lock_outline, obscureText: true),
                        const SizedBox(height: 25),
                        // Create Account Button
                        buildButton(
                          text: "Create Account",
                          onPressed: () async {
                            String email = emailController.text;
                            String firstName = firstNameController.text;
                            String lastName = lastNameController.text;
                            String password = passwordController.text;
                            String confirmPassword = confirmPasswordController.text;

                            // Validate Password Matching
                            if (password != confirmPassword) {
                              ref.read(statusMessageProvider.notifier).state = "Passwords do not match";
                              return;
                            }

                            // Example user ID based on name
                            String userId = "${firstName}_$lastName";
                            await ref.read(authProvider.notifier).signUp(
                              userId: userId,
                              email: email,
                              password: password
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                        // Status Message Display
                        Consumer(
                          builder: (context, ref, child) {
                            final message = ref.watch(statusMessageProvider);
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                message,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // Return Button
                  buildButton(
                    text: "Return",
                    onPressed: () { 
                      ref.read(statusMessageProvider.notifier).state = ""; // Clear message when leaving
                      context.go('/auth');
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Method for Creating Input Fields
  Widget buildTextField({
    required TextEditingController controller,
    required String label,
    IconData? icon,
    required bool obscureText,
  }) {
    return TextField(
      controller: controller,
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
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Archivo', color: Colors.black),
    );
  }

  // Method for Creating Buttons
  Widget buildButton({required String text, required VoidCallback onPressed}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC8E8FF), // Light blue background
        foregroundColor: Colors.black, // Black text
        minimumSize: const Size(200, 60), // Button size
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: onPressed,
      child: Text(text, style: const TextStyle(fontFamily: 'Archivo', fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }
}



