import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class is a state notifier that manages the authentication state of the user.
// It extends StateNotifier<bool>, holding a boolean value representing authentication status.
class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false) {
    checkLoginStatus();
  }

  // Retrieves the stored authentication state from SharedPreferences
  // and updates the state accordingly.
  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isLoggedIn') ?? false;
  }

  // Handles user login, updating the state and persisting the login status.
  Future<void> login() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    state = true;
  }

  // Handles user logout, making a reset of the state and clearing the login status.
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    state = false;
  }
}

// Define a global provider using Riverpod that exposes the AuthNotifier instance.
// This allows other parts of the app to access and listen to authentication state changes.
final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});
