import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/main.dart';
import 'package:semester_project__uprm_pet_adoption/supabase/retrieval.dart';
import 'package:semester_project__uprm_pet_adoption/supabase/upload.dart';
import '../services/storage_service.dart';


class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _ProfileState();
}

class _ProfileState extends State<Maps> {
  final StorageService storageService = StorageService();
  final ProfilePictureService profilePictureService = ProfilePictureService();

  Future<void> handleUpload() async {
    String? result = await storageService.pictureUpload();

    if (!mounted) return; // Ensure widget is still in the tree

    if (result != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('File uploaded successfully!')),
      );
      setState(() {}); // Refresh the UI to display the new profile picture
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error uploading file')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Profile Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User Profile'),
            const SizedBox(height: 20),

            // Display the profile picture
            FutureBuilder<String?>(
              future: profilePictureService.getProfilePictureUrl(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show a loader while fetching
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}'); // Handle errors
                } else if (snapshot.hasData && snapshot.data != null) {
                  // Display the image
                  return Image.network(
                    snapshot.data!,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  );
                } else {
                  // Show a placeholder if no image is found
                  return Icon(Icons.person, size: 100);
                }
              },
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: handleUpload,
              child: const Text('Upload File to Supabase'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.go('/'); // Navigate back to Home
              },
              child: const Text('Return to Home'),
            ),
          ],
        ),
      ),
    );
  }
}