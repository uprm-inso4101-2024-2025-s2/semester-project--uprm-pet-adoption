import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sp;

class StorageService {
  final sp.SupabaseClient supabase = sp.Supabase.instance.client;
  final ImagePicker picker = ImagePicker();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const int maxFileSize = 600 * 1024; // 600KB

  Future<String?> pictureUpload() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('No user is currently logged in');
      return null;
    }

    // Fetch the previous file name from Firestore
    DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
    String? previousFileName = userDoc['profilePicture'];

    // Pick an image from the user's gallery
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      Uint8List fileBytes = await pickedFile.readAsBytes();

      // Check if file size is within the limit
      if (fileBytes.lengthInBytes > maxFileSize) {
        print('File size exceeds limit');
        return null;
      }

      try {
        // Create a unique file name using the user's ID and timestamp
        String fileName = '${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';

        // Delete the previous file from Supabase Storage (if it exists)
        if (previousFileName != null && previousFileName.isNotEmpty) {
          await supabase.storage.from('uploads').remove([previousFileName]);
          print('Previous file deleted: $previousFileName');
        }

        // Upload the new file to Supabase Storage
        await supabase.storage.from('uploads').uploadBinary(fileName, fileBytes);

        // Update Firestore with the new file name
        await _firestore.collection('users').doc(user.uid).update({
          'profilePicture': fileName,
        });

        print('File uploaded and Firestore updated successfully: $fileName');
        return fileName;
      } catch (e) {
        print('Error uploading file: $e');
        return null;
      }
    }

    print('No file selected');
    return null;
  }

  Future<String?> petPictureUpload({required Uint8List fileBytes}) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      print('No user is currently logged in');
      return null;
    }

    if (fileBytes.lengthInBytes > maxFileSize) {
      print('File size exceeds limit');
      return null;
    }

    try {
      String fileName = '${user.uid}_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await supabase.storage.from('uploads').uploadBinary(fileName, fileBytes);
      // await _firestore.collection('pets').doc(user.uid).update({
      //   'petPicture': fileName,
      // });

      print('File uploaded and Firestore updated successfully: $fileName');
      return fileName;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }


  Future<String?> generalFileUpload() async {
    // This function allows for either image or PDFs (example usage: uploading a vaccine document as either a photo or a PDF)
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result == null || result.files.single.bytes == null) return null;

    String? extension = result.files.single.extension;
    Uint8List fileBytes = result.files.single.bytes!;

    if (fileBytes.lengthInBytes > maxFileSize) return null;

    String fileName = DateTime.now().millisecondsSinceEpoch.toString(); // Unique file name

    try {
      // If file chosen is an image
      if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
        await supabase.storage.from('uploads').uploadBinary(fileName, fileBytes);
        return fileName;
      }

      // If file is a PDF
      if (extension == 'pdf') {
        await supabase.storage.from('uploads').uploadBinary(fileName, fileBytes);
        return fileName;
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  
}