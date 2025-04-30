import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceManager extends ChangeNotifier {
  static const String _prefAgeKey = 'preferredAge';
  static const String _prefBreedKey = 'preferredBreed';

  String? _preferredAge;
  String? _preferredBreed;

  String? get preferredAge => _preferredAge;
  String? get preferredBreed => _preferredBreed;

  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    _preferredAge = prefs.getString(_prefAgeKey);
    _preferredBreed = prefs.getString(_prefBreedKey);
    notifyListeners();
  }

  Future<void> savePreferences(String age, String breed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefAgeKey, age);
    await prefs.setString(_prefBreedKey, breed);
    _preferredAge = age;
    _preferredBreed = breed;
    notifyListeners();
  }

  Future<void> clearPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefAgeKey);
    await prefs.remove(_prefBreedKey);
    _preferredAge = null;
    _preferredBreed = null;
    notifyListeners();
  }
}

