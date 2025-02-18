import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';

//To run this test file, run flutter test test/auth_provider_test.dart in the terminal


void main() {
  late AuthNotifier authNotifier;
  late ProviderContainer container;

  setUp(() async {
    // Initialize SharedPreferences with mock values
    SharedPreferences.setMockInitialValues({});
    authNotifier = AuthNotifier();
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  group('AuthNotifier Tests without Mockito', () {
    test('Initial state should be false (logged out)', () {
      expect(authNotifier.state, false);
    });

    test('checkLoginStatus() should load stored login state', () async {
      // Store mock value before checking login status
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await authNotifier.checkLoginStatus();
      expect(authNotifier.state, true); // State should update to true
    });

    test('login() should set state to true and persist in SharedPreferences', () async {
      await authNotifier.login();
      expect(authNotifier.state, true);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('isLoggedIn'), true);
    });

    test('logout() should set state to false and clear SharedPreferences', () async {
      await authNotifier.logout();
      expect(authNotifier.state, false);

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getBool('isLoggedIn'), false);
    });
  });
}
