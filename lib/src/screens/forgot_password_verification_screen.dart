import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ForgotPasswordVerificationScreen extends StatelessWidget {
  const ForgotPasswordVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Helper to build each code box (4 in total).
    Widget buildCodeBox() {
      return Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: TextField(
          maxLength: 1,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: "", // Hide the default character counter
            filled: true,
            fillColor: Colors.grey[200], 
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          // Go back to the Forgot Password screen
          onPressed: () => context.go('/forgot_password'),
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
            // SHIFTED ILLUSTRATION 
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: SizedBox(
                height: 200,
                width: 200,
                child: Image.asset(
                  'assets/images/verification_phone.png', 
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // TITLE
            const Text(
              'Please enter your Verification Code',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),

            // SUBTITLE
            const Text(
              'We have sent verification Code\n'
              'to registered Email ID',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            // CODE BOXES
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildCodeBox(),
                buildCodeBox(),
                buildCodeBox(),
                buildCodeBox(),
              ],
            ),
            const SizedBox(height: 40),

            // "DONE" button -> goes to Forgot Password Change screen
            ElevatedButton(
              onPressed: () {
                context.go('/forgot_password_change');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                padding: const EdgeInsets.symmetric(
                  horizontal: 64,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              child: const Text('DONE'),
            ),
          ],
        ),
      ),
    );
  }
}
