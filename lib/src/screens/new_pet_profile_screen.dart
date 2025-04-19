import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets.dart'; // Import for navigation

class NewPet extends StatelessWidget {
  const NewPet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Pet Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Other fields like pet name, breed, etc...

            SizedBox(height: 20),
            Text("Health Documents", style: TextStyle(fontWeight: FontWeight.bold)),
            HealthDocumentsUploader(),

            // Add Submit button, etc...
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBar(selectedIndex: 2),
    );
  }
}
