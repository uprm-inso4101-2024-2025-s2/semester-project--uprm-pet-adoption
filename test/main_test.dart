import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:semester_project__uprm_pet_adoption/main.dart';
import 'package:semester_project__uprm_pet_adoption/src/providers/auth_provider.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/login_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';

//To run this test file, run "flutter test test/main_test.dart" in the terminal

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('App should be wrapped with ProviderScope', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    expect(find.byType(ProviderScope), findsOneWidget);
  });

  testWidgets('Displays LoginScreen when user is not authenticated', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Ensure LoginScreen is shown
    expect(find.byType(LogInScreen), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
  });

  testWidgets('Displays HomeScreen when user is authenticated', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'isLoggedIn': true});

    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Ensure HomeScreen is shown
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(LogInScreen), findsNothing);
  });

  testWidgets('Login updates UI to show HomeScreen', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Ensure LoginScreen is shown initially
    expect(find.byType(LogInScreen), findsOneWidget);

    // Simulate login
    await tester.tap(find.text('Log In'));
    await tester.pumpAndSettle();

    // Ensure HomeScreen is now shown
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Logout updates UI to show LoginScreen', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'isLoggedIn': true});

    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Ensure HomeScreen is shown initially
    expect(find.byType(HomeScreen), findsOneWidget);

    // Simulate logout
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    // Ensure LoginScreen is now shown
    expect(find.byType(LogInScreen), findsOneWidget);
  });

  testWidgets('Auth state persists across app restarts', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'isLoggedIn': true});

    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Ensure HomeScreen is shown initially
    expect(find.byType(HomeScreen), findsOneWidget);

    // Simulate app restart
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    // Ensure HomeScreen is still shown
    expect(find.byType(HomeScreen), findsOneWidget);
  });

  testWidgets('Logging out persists state as logged out after restart', (WidgetTester tester) async {
    SharedPreferences.setMockInitialValues({'isLoggedIn': true});

    await tester.pumpWidget(const ProviderScope(child: MyApp()));

    // Ensure HomeScreen is shown initially
    expect(find.byType(HomeScreen), findsOneWidget);

    // Simulate logout
    await tester.tap(find.byIcon(Icons.logout));
    await tester.pumpAndSettle();

    // Simulate app restart
    await tester.pumpWidget(const ProviderScope(child: MyApp()));
    await tester.pumpAndSettle();

    // Ensure LoginScreen is now shown
    expect(find.byType(LogInScreen), findsOneWidget);
  });
}
