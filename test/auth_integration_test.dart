import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/auth_screen.dart';

//To run this test file, run flutter test test/auth_integration_test.dart in the terminal

void main() {
  late ProviderContainer container;

  setUp(() async {
    SharedPreferences.setMockInitialValues({}); // Reset mock storage before each test
    container = ProviderContainer();
  });

  tearDown(() {
    container.dispose();
  });

  Widget createTestApp() {
    return ProviderScope(
      child: MaterialApp(
        home: Consumer(
          builder: (context, ref, child) {
            final isLoggedIn = ref.watch(authProvider);
            return isLoggedIn ? const HomeScreen() : const AuthScreen();
          },
        ),
      ),
    );
  }

  group('AuthProvider Integration Tests', () {
    testWidgets('Shows LoginScreen if user is logged out', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      expect(find.byType(AuthScreen), findsOneWidget);
    });

    testWidgets('Shows HomeScreen if user is logged in', (WidgetTester tester) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await tester.pumpWidget(createTestApp());
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Logging in switches to HomeScreen dynamically', (WidgetTester tester) async {
      await tester.pumpWidget(createTestApp());
      expect(find.byType(AuthScreen), findsOneWidget);

      final authNotifier = container.read(authProvider.notifier);
      await authNotifier.login();
      await tester.pump(); // Rebuild UI

      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('Logging out switches to LoginScreen dynamically', (WidgetTester tester) async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      await tester.pumpWidget(createTestApp());
      expect(find.byType(HomeScreen), findsOneWidget);

      final authNotifier = container.read(authProvider.notifier);
      await authNotifier.logout();
      await tester.pump(); // Rebuild UI

      expect(find.byType(AuthScreen), findsOneWidget);
    });
  });
}
