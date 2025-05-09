import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/services/auth_service.dart';
import 'package:semester_project__uprm_pet_adoption/analytics_service.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initializing controllers for username and password input fields
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    AnalyticsService().logScreenView("login_screen");
  }

  @override
  void dispose() {
    // Disposing controllers to prevent memory leaks
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Watching status message from the provider
    final statusMessage = ref.watch(statusMessageProvider);

        // Function to validate email
    bool validateEmail(String email) {
      return email.contains('@') && email.split('@').last.contains('.');
    }

    // Function which validates if the password has at least 1 number
    bool validatePassword(String password) {
      final RegExp regex = RegExp(r'\d');
      return regex.hasMatch(password);
    }

    // Function which validates if the password has at least 1 special character
    bool validateSpecialCharacter(String password) {
      final RegExp regex = RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:"\\|,.<>\/?]');
      return regex.hasMatch(password);
    }

    // Function to handle login
    void handleLogin() async{
     
        setState(() {
        isLoading = true; // Start loading
      });
     
      String email = usernameController.text.trim();
      String password = passwordController.text.trim();

      // Email validation
      if (!validateEmail(email)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Email'),
              content: const Text('Please enter a valid email.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      if (password.isEmpty) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Password'),
              content: const Text('Password cannot be empty.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      if(password.length < 6) {
          showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Password'),
              content: const Text('Password must be at least 6 characters long.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      if(!validatePassword(password)){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Password'),
              content: const Text('Password must contain at least 1 digit.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      if(!validateSpecialCharacter(password)){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Invalid Password'),
              content: const Text('Password must contain at least 1 special character.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      // Directly set isLoggedIn to true
      ref.read(authProvider.notifier).state= await AuthService().signIn(
        email: email,
        password: password,
        );
      context.go('/');

      try {
        bool success = await AuthService().signIn(email: email, password: password);
        if (success) {
          context.go('/');
        } else {
          // Handle failed login
        }
      } catch (e) {
        // Handle error
      } finally {
        setState(() {
          isLoading = false;  // Hide loading indicator
        });
      }
    }

    return Container(
      decoration: const BoxDecoration(
        // Setting background image
        image: DecorationImage(
          image: AssetImage('assets/images/Login_SignUp_Background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        //AppBar is a prebuilt widget in Flutter
        appBar: AppBar(
            toolbarHeight: -5,
            backgroundColor: Color(0xFF82B0FF),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Login title
              const Padding(
                padding: EdgeInsets.only(bottom: 30),
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, fontFamily: 'Archivo'),
                ),
              ),
              // Login form container
            if (isLoading)  // Show the loading spinner when isLoading is true
              const CircularProgressIndicator(),
            if (!isLoading)  // Show the login form when not loading
              Container(
                height: 375,
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
                  children: [
                    // Username input field
                    TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 3.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                        ),
                        labelText: "Username",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Archivo',
                          color: Colors.black,
                        ),
                        suffixIcon: Icon(Icons.person_outline_sharp, color: Color(0xFF5D5793)),
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Password input field
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 3.0),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black, width: 2.0),
                        ),
                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Archivo',
                          color: Colors.black,
                        ),
                        suffixIcon: Icon(Icons.lock_outline),
                      ),
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Archivo',
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    // "Forgot Password?" text button
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                    onPressed: () {
                    // Navigate to the Forgot Password screen
                    context.go('/forgot_password');
                    },
                    child: const Text('Forgot Password?'),
                    ),
                    ),
                    const SizedBox(height: 15),
                    // Login button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC8E8FF),
                        foregroundColor: Colors.black,
                        minimumSize: const Size(200, 60),
                      ),
                        onPressed: isLoading ? null : () {
                            handleLogin();
                          },
                      child: const Text(
                        'Log In',
                        style: TextStyle(fontFamily: 'Archivo', fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    // Display status message
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        statusMessage,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              // Return button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFC8E8FF),
                  foregroundColor: Colors.black,
                  minimumSize: const Size(200, 60),
                ),
                onPressed: () {
                  // Navigate back to authentication screen
                  context.go('/auth');
                },
                child: const Text(
                  'Return',
                  style: TextStyle(fontFamily: 'Archivo', fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



