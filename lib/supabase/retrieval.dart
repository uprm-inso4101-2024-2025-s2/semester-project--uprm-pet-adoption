import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePictureService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch the profile picture URL
  Future<String?> getProfilePictureUrl() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch the user's document from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(user.uid)
          .get();

      if (userDoc.exists) {
        // Get the file name from the 'Profile_picture' field
        String fileName = userDoc['Profile_picture'];

        // Construct the Supabase Storage URL
        return getSupabaseImageUrl(fileName);
      }
    }

    return null; // Return null if no file is found
  }

  // Helper function to construct the Supabase Storage URL
  String getSupabaseImageUrl(String fileName) {
    return 'https://csrsmxmhiqwcalunugzf.supabase.co/storage/v1/object/public/uploads/$fileName';
  }
}