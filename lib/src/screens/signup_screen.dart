import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/services/auth_service.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/services/database_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/gettoknow_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';

import 'package:semester_project__uprm_pet_adoption/models/user.dart';
import '../screens/loading_screen.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final DatabaseService _databaseService = DatabaseService();
  final AuthService authService = AuthService();

  final _formKey = GlobalKey<FormState>();

  late final TextEditingController emailController;
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    AnalyticsService().logScreenView("signup_screen");
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

    void _showLoadingScreen(BuildContext context) {
    // Push the loading screen onto the navigation stack
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoadingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/Login_SignUp_Background.png',
              fit: BoxFit.cover,
            ),
          ),
          // Sign-Up Form
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                            obscureText: false,
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter an email";
                              }

                              final allowedDomains = [
                                '@gmail.com',
                                '@yahoo.com',
                                '@upr.edu'
                              ];

                              if (!RegExp(
                                      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                                  .hasMatch(value)) {
                                return "Invalid email format";
                              }

                              bool isValDomain = allowedDomains
                                  .any((domain) => value.endsWith(domain));
                              if (!isValDomain) {
                                return "Please use a valid email domain";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: buildTextField(
                                  label: "First Name",
                                  obscureText: false,
                                  controller: firstNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter first name";
                                    }
                                    if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$")
                                        .hasMatch(value)) {
                                      return "Invalid characters";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: buildTextField(
                                  label: "Last Name",
                                  obscureText: false,
                                  controller: lastNameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Enter last name";
                                    }
                                    if (!RegExp(r"^[A-Za-zÀ-ÖØ-öø-ÿ\s]+$")
                                        .hasMatch(value)) {
                                      return "Invalid characters";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            label: "Password",
                            icon: Icons.lock_outline,
                            obscureText: true,
                            controller: passwordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter a password";
                              }
                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              if (!RegExp(
                                      r'^(?=.*[0-9])(?=.*[!@#\$%^&*(),.?":{}|<>]).{6,}$')
                                  .hasMatch(value)) {
                                return "Must include a number and a special character";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          buildTextField(
                            label: "Confirm Password",
                            icon: Icons.lock_outline,
                            obscureText: true,
                            controller: confirmPasswordController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Confirm your password";
                              } else if (value != passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 25),
                          buildButton(
                              text: "Create Account",
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  _showLoadingScreen(context);
                                  
                                  await authService.signUp(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      firstName: firstNameController.text,
                                      lastName: lastNameController.text
                                    );

                                  //Create user with signup inputs
                                  User user = User(
                                      First_name: firstNameController.text,
                                      Last_name: lastNameController.text,
                                      Location: "",
                                      Password: passwordController.text,
                                      Pet: "",
                                      Pet_picture: 0,
                                      Phone_number: "000000000",
                                      Profile_picture: 0,
                                      email: emailController.text);
                                  //Add user to database
                                  _databaseService.addUser(user);
                                  context.go('/gettoknowyou');

                                  Navigator.of(context).pop();
                                  context.go('/gettoknow');

                                  AnalyticsService().addSignUp();
                                  context.go('/gettoknowyou');
                                  
                                }
                              })
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    buildButton(
                      text: "Return",
                      onPressed: () {
                        ref.read(statusMessageProvider.notifier).state =
                            ""; // Clear message when leaving
                        context.go('/auth');
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField({
    required String label,
    IconData? icon,
    required bool obscureText,
    required TextEditingController controller,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
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
            suffixIcon:
                icon != null ? Icon(icon, color: Color(0xFF5D5793)) : null,
          ),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Archivo',
            color: Colors.black,
          ),
          validator: validator,
        ),
        const SizedBox(height: 10),
      ],
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
