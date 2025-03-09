import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart'; // Import for navigation

class DMScreen extends StatelessWidget {
  const DMScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("DMS")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Chat",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ]
        ),
        ),
    );
  }
}
