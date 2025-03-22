import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordChangeScreen extends StatefulWidget {
  const ForgotPasswordChangeScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordChangeScreen> createState() => _ForgotPasswordChangeScreenState();
}

class _ForgotPasswordChangeScreenState extends State<ForgotPasswordChangeScreen> {
  bool _obscureNewPassword = true;
  bool _obscureReenterPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          // Back arrow returns to Verification screen
          onPressed: () => context.go('/forgot_password_verification'),
        ),
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset(
                'assets/images/password_change.png', 
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),

            // Instruction text
            const Text(
              'Please enter new password',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            //Password field with thin light blue border
            TextField(
              obscureText: _obscureNewPassword,
              decoration: InputDecoration(
                labelText: 'New Password',
                prefixIcon: const Icon(Icons.key, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNewPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureNewPassword = !_obscureNewPassword;
                    });
                  },
                ),
                fillColor: const Color(0xFFF5F5F5),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Re-enter Password field with thin light blue border
            TextField(
              obscureText: _obscureReenterPassword,
              decoration: InputDecoration(
                labelText: 'Re-enter Password',
                prefixIcon: const Icon(Icons.key, color: Colors.grey),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureReenterPassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureReenterPassword = !_obscureReenterPassword;
                    });
                  },
                ),
                fillColor: const Color(0xFFF5F5F5),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 30),

            // "CHANGE PASSWORD" button -> goes to Login
            ElevatedButton(
              onPressed: () {
                // After changing password, return to login
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                padding: const EdgeInsets.symmetric(
                  horizontal: 64,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('CHANGE PASSWORD'),
            ),
          ],
        ),
      ),
    );
  }
}
