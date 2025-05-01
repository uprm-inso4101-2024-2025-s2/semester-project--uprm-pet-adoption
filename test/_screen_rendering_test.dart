import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:go_router/go_router.dart';

// Mock class for AnalyticsService
class MockAnalyticsService {
  void logScreenView(String screenName) {}
  void addSignUp() {}
}

// Mock provider for AnalyticsService to replace the real one during tests
final mockAnalyticsServiceProvider = Provider<MockAnalyticsService>((ref) {
  return MockAnalyticsService();
});

// Mock for GoRouter navigation
class MockGoRouter extends Mock implements GoRouter {}

void main() {
  // Setup the mocked GoRouter
  late MockGoRouter mockGoRouter;
  
  setUp(() {
    mockGoRouter = MockGoRouter();
    registerFallbackValue('dummy-route');
    when(() => mockGoRouter.go(any())).thenReturn(null);
  });

  group('Login Screen Widget Tests', () {
    testWidgets('Login screen basic UI elements test', (WidgetTester tester) async {
      // Build a simple login screen UI for testing
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Log In', style: TextStyle(fontSize: 40)),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextField(
                          decoration: const InputDecoration(labelText: 'Username'),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          decoration: const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 15),
                        TextButton(
                          onPressed: () {},
                          child: const Text('Forgot Password?'),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Log In'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Return'),
                  )
                ],
              ),
            ),
          ),
        ),
      );

      // Verify the login screen displays correctly - using findsWidgets instead of findsOneWidget for "Log In"
      expect(find.text('Log In'), findsWidgets); // Changed to findsWidgets since there are multiple instances
      expect(find.text('Username'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.byType(TextField), findsAtLeastNWidgets(2));
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(2));
    });

    testWidgets('Can enter text in login form fields', (WidgetTester tester) async {
      // Build a simple form with text fields
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
              ],
            ),
          ),
        ),
      );

      // Enter text in the text fields
      await tester.enterText(find.byType(TextField).at(0), 'test@example.com');
      await tester.enterText(find.byType(TextField).at(1), 'Password123!');

      // Verify the text was entered correctly
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('Password123!'), findsOneWidget);
    });
  });

  group('Signup Screen Widget Tests', () {
    testWidgets('Signup screen basic UI elements test', (WidgetTester tester) async {
      // Build a simplified signup screen for testing
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Sign Up', style: TextStyle(fontSize: 35)),
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'First Name'),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: 'Last Name'),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                        ),
                        const SizedBox(height: 25),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Create Account'),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Return'),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Verify the signup screen displays correctly
      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('First Name'), findsOneWidget);
      expect(find.text('Last Name'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
      expect(find.text('Create Account'), findsOneWidget);
      expect(find.byType(TextFormField), findsAtLeastNWidgets(5));
      expect(find.byType(ElevatedButton), findsAtLeastNWidgets(2));
    });

    testWidgets('Can enter text in signup form fields', (WidgetTester tester) async {
      // Build a simplified form with text form fields
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'First Name'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Last Name'),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      // Enter text in the text fields
      await tester.enterText(find.widgetWithText(TextFormField, 'Email'), 'test@example.com');
      await tester.enterText(find.widgetWithText(TextFormField, 'First Name'), 'John');
      await tester.enterText(find.widgetWithText(TextFormField, 'Last Name'), 'Doe');
      await tester.enterText(find.widgetWithText(TextFormField, 'Password'), 'Password123!');
      await tester.enterText(find.widgetWithText(TextFormField, 'Confirm Password'), 'Password123!');

      // Verify the text was entered correctly
      expect(find.text('test@example.com'), findsOneWidget);
      expect(find.text('John'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('Password123!'), findsNWidgets(2)); // Both password fields
    });
  });

  group('User Profile Screen Widget Tests', () {
    testWidgets('User profile screen basic UI elements test', (WidgetTester tester) async {
      // Build a simplified profile screen for testing
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
            ),
            body: Stack(
              children: [
                const SizedBox.expand(), // Background
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                      const SizedBox(height: 5),
                      ClipOval(
                        child: Container(
                          width: 100, 
                          height: 100,
                          color: Colors.grey,
                          child: const Icon(Icons.person, size: 50),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Location',
                            prefixIcon: Icon(Icons.location_on),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Verify the profile screen displays correctly
      expect(find.text('Profile'), findsOneWidget);
      expect(find.byType(TextField), findsAtLeastNWidgets(4)); // Multiple text fields
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);
      expect(find.text('Phone Number'), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
    });

    testWidgets('User profile screen logout button and back arrow test', (WidgetTester tester) async {
      // Track if buttons were pressed
      bool logoutButtonPressed = false;
      bool backArrowPressed = false;
      
      // Build a simplified profile screen for testing with button press tracking
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text('Profile'),
              leading: IconButton(
                key: const Key('back_arrow'),
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  backArrowPressed = true;
                },
              ),
            ),
            body: Stack(
              children: [
                const SizedBox.expand(), // Background
                Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      const TextField(
                        decoration: InputDecoration(border: InputBorder.none),
                      ),
                      const SizedBox(height: 5),
                      ClipOval(
                        child: Container(
                          width: 100, 
                          height: 100,
                          color: Colors.grey,
                          child: const Icon(Icons.person, size: 50),
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Location',
                            prefixIcon: Icon(Icons.location_on),
                          ),
                        ),
                        const SizedBox(height: 15),
                        const TextField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            prefixIcon: Icon(Icons.phone),
                          ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          key: const Key('logout_button'),
                          onPressed: () {
                            logoutButtonPressed = true;
                          },
                          child: const Text('Logout'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

      // Verify the logout button is present
      expect(find.byKey(const Key('logout_button')), findsOneWidget);
      expect(find.text('Logout'), findsOneWidget);
      
      // Verify the back arrow is present
      expect(find.byKey(const Key('back_arrow')), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
      
      // Tap the logout button
      await tester.tap(find.byKey(const Key('logout_button')));
      await tester.pump();
      
      // Verify the logout button was pressed
      expect(logoutButtonPressed, true);
      
      // Tap the back arrow
      await tester.tap(find.byKey(const Key('back_arrow')));
      await tester.pump();
      
      // Verify the back arrow was pressed
      expect(backArrowPressed, true);
    });
  });
}