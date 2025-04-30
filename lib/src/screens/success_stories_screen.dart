import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SuccessStoriesScreen extends StatelessWidget {
  const SuccessStoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Success Stories',
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Archivo',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFF581),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: const Center(
        child: Text(
          'Placeholder!',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
