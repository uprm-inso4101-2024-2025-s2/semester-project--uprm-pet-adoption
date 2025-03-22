import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signup({

    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String phoneNumber,

  })async {

    try{

      // Create the user in Firebase Authentication
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's UID
      String uid = userCredential.user!.uid;

      await _firestore.collection('users').doc(uid).set({
        'First_name': firstName,
        'Last_name': lastName,
        'Location': '', // Initialize with an empty string
        'Password': password, // Note: Storing passwords in Firestore is not recommended
        'Pet': '', // Initialize with an empty string
        'Pet_picture': '', // Initialize with an empty string
        'Phone_number': phoneNumber,
        'Profile_picture': '', // Initialize with an empty string
        'email': email,
        'created_at': FieldValue.serverTimestamp(), // Optional: Add a timestamp
      });
        
    } on FirebaseAuthException catch(e){
      String message = '';
      if(e.code == 'weak-password') {
        message = 'The passwoprd provided is too weak.';
      } else if(e.code == 'email-already-in-use'){
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
    }
    catch(e){
      print('Error during signup: $e');
    }
  }
  
  Future<bool> signin({
    required String email,
    required String password,
  })async {

    try{

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user's UID
      String uid = userCredential.user!.uid;

      // Check if the user's document exists in Firestore
      DocumentSnapshot userDoc = await _firestore.collection('users').doc(uid).get();

      if (!userDoc.exists) {
        // If the document doesn't exist, create it
        await _firestore.collection('users').doc(uid).set({
          'First_name': '', // Initialize with an empty string
          'Last_name': '', // Initialize with an empty string
          'Location': '', // Initialize with an empty string
          'Password': password, // Note: Storing passwords in Firestore is not recommended
          'Pet': '', // Initialize with an empty string
          'Pet_picture': '', // Initialize with an empty string
          'Phone_number': '', // Initialize with an empty string
          'Profile_picture': '', // Initialize with an empty string
          'email': email,
          'created_at': FieldValue.serverTimestamp(), // Optional: Add a timestamp
        });
      }

      return true;

    } on FirebaseAuthException catch(e){
      String message = '';
      if(e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if(e.code == 'wrong-password'){
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
    }
    catch(e){
      return false;
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