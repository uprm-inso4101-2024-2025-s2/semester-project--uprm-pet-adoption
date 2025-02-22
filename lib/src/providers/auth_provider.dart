import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// AuthNotifier manages authentication state using SharedPreferences
class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier(this.ref) : super(false) {
    _initAuthState(); // Initialize authentication state on creation
  }

  final Ref ref;

  // Initializes authentication state from shared preferences
  Future<void> _initAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isLoggedIn') ?? false;
  }

  // Handles user sign-up and stores credentials locally
  Future<void> signUp({
    required String userId,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Use unique keys per user
    final storedUser = prefs.getString('user_$userId');

    if (storedUser != null) {
      ref.read(statusMessageProvider.notifier).state = "User already exists: $userId";
      return;
    }

    // Storing user credentials
    await prefs.setString('user_$userId', userId);
    await prefs.setString('email_$userId', email);
    await prefs.setString('password_$userId', password); // Store password securely in real apps
    await prefs.setBool('isLoggedIn', true);
    state = true;

    ref.read(statusMessageProvider.notifier).state = "Signup successful!";
  }

  // Handles user login by verifying stored credentials
  Future<void> login({required String userId, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    
    final storedUserId = prefs.getString('user_$userId');
    final storedPassword = prefs.getString('password_$userId');

    if (storedUserId == null || storedPassword == null) {
      ref.read(statusMessageProvider.notifier).state = "User doesn't exist";
      return;
    }

    // Verify user credentials
    if (storedUserId == userId && storedPassword == password) {
      await prefs.setBool('isLoggedIn', true);
      state = true;
      ref.read(statusMessageProvider.notifier).state = "Login successful!";
    } else {
      ref.read(statusMessageProvider.notifier).state = "Incorrect username or password";
    }
  }

  // Handles user logout and clears authentication state
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    state = false;
    ref.read(statusMessageProvider.notifier).state = "Logged out";
  }
}

// Authentication state provider
final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier(ref);
});

// Status message provider for UI feedback
final statusMessageProvider = StateProvider<String>((ref) => "");

