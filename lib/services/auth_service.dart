import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUp({
    required String firstName,
    required String lastName,
    required String password,
    required String email,
  }) async {
    try {
      // Create the user in Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's UID
      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'location': '', // Initialize with an empty string
        'password': password, // Note: Storing passwords in Firestore is not recommended
        'pet': '', // Initialize with an empty string
        'phoneNumber': '', // Initialize with an empty string
        'profilePicture': '', // Initialize with an empty string
        'email': email,
        'createdAt': FieldValue.serverTimestamp(), // Optional: Add a timestamp
      });
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'weak-password') {
        message = 'The passwoprd provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that email.';
      }

      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      print('Error during signup: $e');
    }
  }

  Future<bool> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's UID
      String uid = userCredential.user!.uid;

      // Check if the user's document exists in Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        // If the document doesn't exist, create it
        await _firestore.collection('users').doc(uid).set({
          'firstName': '', // Initialize with an empty string
          'lastName': '', // Initialize with an empty string
          'location': '', // Initialize with an empty string
          'password': password, // Note: Storing passwords in Firestore is not recommended
          'pet': '', // Initialize with an empty string
          'phoneNumber': '', // Initialize with an empty string
          'profilePicture': '', // Initialize with an empty string
          'email': email,
          'createdAt':
              FieldValue.serverTimestamp(), // Optional: Add a timestamp
        });
      }

      return true;
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'wrong password provided for that user';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<void> petsSignUp({
    required String medicalDocument,
    required String petPicture,
    required String petAge,
    required String petBreed,
    required String petDescription,
    required String petName,
    required String petShelter,
    required String petTags,
  }) async {
    try {
      // Get the currently signed-in user
      User? currentUser = _auth.currentUser;

      if (currentUser == null) {
        Fluttertoast.showToast(
          msg: 'You must be signed in to register a pet.',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0,
        );
        return;
      }

      // Get the user's UID
      String uid = currentUser.uid;

      await _firestore.collection('pets').add({
        'medicalDocument': medicalDocument,
        'petPicture': petPicture,
        'petAge': petAge, // contains one of 3 options (Puppy, Adult, Elderly)
        'petBreed': petBreed, // contains the breed of the pet either from the selection or option other
        'petDescription': petDescription, // description and details that user gives of the pet
        'petName': petName, // created pets name
        'petOwner': uid, // the user who registered this pet
        'petShelter': petShelter, // the shelter that registered this pet
        'petTags': petTags, //specific tags chosen from the new pet profile screen
        'createdAt': FieldValue.serverTimestamp(), // Optional: Add a timestamp
      });

      Fluttertoast.showToast(
        msg: 'Pet registered successfully!',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.green[600],
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } catch (e) {
      print('Error during pet registration: $e');
      Fluttertoast.showToast(
        msg: 'Something was went wrong while registering the pet.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.red[600],
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  Future<void> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: 'Password reset email sent. Check your inbox.',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    } on FirebaseAuthException catch (e) {
      String message = '';
      if (e.code == 'user-not-found') {
        message = 'No user found with that email.';
      } else {
        message = 'An error occurred. Please try again.';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
  }

  // Specific user Doc
  Future<Object?> getUserDoc() async {
    // Get the current user
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Fetch the user's document from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        // Return userDoc which can be used to access specific
        // user data
        return userDoc;
      }
    }

    return null; // Return null if no file is found
  }

  // Fetch User First Name
  Future<String?> getUserFirstName() async {
    final userDoc = await getUserDoc();

    if (userDoc != null && userDoc is DocumentSnapshot) {
      final data = userDoc.data() as Map<String, dynamic>;
      return data['firstName'] as String?;
    }

    return null;
  }

  // Fetch User Last Name
  Future<String?> getUserLastName() async {
    final userDoc = await getUserDoc();

    if (userDoc != null && userDoc is DocumentSnapshot) {
      final data = userDoc.data() as Map<String, dynamic>;
      return data['lastName'] as String?;
    }

    return null;
  }

  // Fetch User Location
  Future<String?> getUserLocation() async {
    final userDoc = await getUserDoc();

    if (userDoc != null && userDoc is DocumentSnapshot) {
      final data = userDoc.data() as Map<String, dynamic>;
      return data['location'] as String?;
    }

    return null;
  }

  // Fetch User Phone number
  Future<String?> getUserPhoneNumber() async {
    final userDoc = await getUserDoc();

    if (userDoc != null && userDoc is DocumentSnapshot) {
      final data = userDoc.data() as Map<String, dynamic>;
      return data['phoneNumber'] as String?;
    }

    return null;
  }

  // Fetch User email
  Future<String?> getUserEmail() async {
    final userDoc = await getUserDoc();

    if (userDoc != null && userDoc is DocumentSnapshot) {
      final data = userDoc.data() as Map<String, dynamic>;
      return data['email'] as String?;
    }

    return null;
  }

  // This feauture is implemented but not used anywhere due to front end not being available at time of development
  // TODO: Implement sign in when front end is available

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
