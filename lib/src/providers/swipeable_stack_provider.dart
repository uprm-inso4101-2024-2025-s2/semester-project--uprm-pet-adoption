import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// This class is a state notifier that manages the SwipeableStackentication state of the user.
class SwipeableStackNotifier extends StateNotifier<bool> {
  SwipeableStackNotifier() : super(false) {
    checkSwipeStatus();
  }

  // Retrieves the stored SwipeableStackentication state from SharedPreferences
  // and updates the state accordingly.
  Future<void> checkSwipeStatus() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isPressed') ?? false;
  }

  // Handles user login, updating the state and persisting the login status.
  Future<void> isFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPresssed', true);
    state = true;
  }

  // Handles user logout, making a reset of the state and clearing the login status.
  Future<void> isNotFavorite() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPressed', false);
    state = false;
  }
}

// Define a global provider using Riverpod that exposes the SwipeableStackNotifier instance.
// This allows other parts of the app to access and listen to SwipeableStackentication state changes.
final SwipeableStackProvider = StateNotifierProvider<SwipeableStackNotifier, bool>((ref) {
  return SwipeableStackNotifier();
});
