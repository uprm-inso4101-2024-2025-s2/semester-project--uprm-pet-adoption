import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';

class AuthService{

  Future<void> signup({
    required String email,
    required String password
  })async {

    try{

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email, password: password
        );
        
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

    }
  }
  
  Future<bool> signin({
    required String email,
    required String password,
  })async {

    try{

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, 
        password: password
        );
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
}