// This is a Flutter Navigation Test.
//
// This test verifies that the app's navigation system works accordingly by 
// checking wether users can transition between screens as expected.
// 
// Test Navigation Flow:
// 1. Start at HomeScreen.
// 2. Navigates to AuthScreen and verifies the transition between screens.
// 3. Navigates to MenuScreen and verifies the transition between screens.
//
// What is expected:
// -Each screen should render correctly when navigated to.
// -No unexpected screens should be present at any given state.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:semester_project__uprm_pet_adoption/main.dart';
import 'package:semester_project__uprm_pet_adoption/src/routes/app_router.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/auth_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/menu_screen.dart';

void main() {
  testWidgets('Navigation Test: Home -> Sign-In -> Menu', (WidgetTester tester) async {
    // Build the app with the initial screen (HomeScreen).
    await tester.pumpWidget(const MyApp());

    // Verify if we are first at HomeScreen.
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(AuthScreen), findsNothing);
    expect(find.byType(MenuScreen), findsNothing);

    // Navigate to AuthScreen.
    appRouter.go('/signin');
    await tester.pumpAndSettle();

    // Verify that we are now at the AuthScreen.
    expect(find.byType(AuthScreen), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
    expect(find.byType(MenuScreen), findsNothing);

    // Navigate to MenuScreen.
    appRouter.go('/menu');
    await tester.pumpAndSettle();

    // Verify that we are now at the MenuScreen.
    expect(find.byType(MenuScreen), findsOneWidget);
    expect(find.byType(HomeScreen), findsNothing);
    expect(find.byType(AuthScreen), findsNothing);
  });
}
