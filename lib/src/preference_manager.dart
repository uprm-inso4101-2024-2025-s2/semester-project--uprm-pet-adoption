import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager extends StateNotifier<PreferenceState> {
  static const String _prefAgeKey = 'preferredAge';
  static const String _prefBreedKey = 'preferredBreed';

  PreferenceManager() : super(const PreferenceState());

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    state = state.copyWith(
      preferredAge: prefs.getString(_prefAgeKey),
      preferredBreed: prefs.getString(_prefBreedKey),
    );
  }

  Future<void> savePreferences(String age, String breed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefAgeKey, age);
    await prefs.setString(_prefBreedKey, breed);
    state = state.copyWith(
      preferredAge: age,
      preferredBreed: breed,
    );
  }

  Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefAgeKey);
    await prefs.remove(_prefBreedKey);
    state = const PreferenceState();
  }
}

class PreferenceState {
  final String? preferredAge;
  final String? preferredBreed;

  const PreferenceState({
    this.preferredAge,
    this.preferredBreed,
  });

  PreferenceState copyWith({
    String? preferredAge,
    String? preferredBreed,
  }) {
    return PreferenceState(
      preferredAge: preferredAge ?? this.preferredAge,
      preferredBreed: preferredBreed ?? this.preferredBreed,
    );
  }
}

// Create a provider
final preferenceManagerProvider = StateNotifierProvider<PreferenceManager, PreferenceState>((ref) {
  return PreferenceManager();
});