import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mocktail/mocktail.dart';
import 'package:semester_project__uprm_pet_adoption/src/widgets/pet_card.dart';
import 'package:semester_project__uprm_pet_adoption/src/screens/home_screen.dart';
import 'package:semester_project__uprm_pet_adoption/firebase_options.dart';

class MockPetStackNotifier extends Mock implements PetStackNotifier {}

void main() {
  late MockPetStackNotifier mockNotifier;

  // Set up Firebase before tests
  setUpAll(() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform); // Initialize Firebase
  });

  setUp(() {
    mockNotifier = MockPetStackNotifier();
  });

  testWidgets('HomeScreen shows pet cards when available', (tester) async {
    when(() => mockNotifier.state).thenReturn([
      PetCard(
        petName: 'Buddy',
        petBreed: 'Labrador',
        petAge: 'Puppy',
        petImages: ['https://example.com/image.jpg'],
        petDescription: 'A friendly dog looking for a home.',
        petTags: ['playful', 'friendly'],
        isFavorite: false,
        onFavoriteToggle: () {},
        onAdopt: () {},
        onAccept: () {},
        onReject: () {},
      ),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          petStackProvider.overrideWith(
            (ref) => mockNotifier,
          ),
        ],
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Buddy'), findsOneWidget);
  });

  testWidgets('HomeScreen shows "No more pets to show!" when no pets are available', (tester) async {
    when(() => mockNotifier.state).thenReturn([]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          petStackProvider.overrideWith(
            (ref) => mockNotifier,
          ),
        ],
        child: MaterialApp(
          home: HomeScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text("No more pets to show!"), findsOneWidget);
  });

  testWidgets('HomeScreen navigation to matchmaking screen works', (tester) async {
    when(() => mockNotifier.state).thenReturn([
      PetCard(
        petName: 'Buddy',
        petBreed: 'Labrador',
        petAge: 'Puppy',
        petImages: ['https://example.com/image.jpg'],
        petDescription: 'A friendly dog looking for a home.',
        petTags: ['playful', 'friendly'],
        isFavorite: false,
        onFavoriteToggle: () {},
        onAdopt: () {},
        onAccept: () {},
        onReject: () {},
      ),
    ]);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          petStackProvider.overrideWith(
            (ref) => mockNotifier,
          ),
        ],
        child: MaterialApp(
          home: HomeScreen(),
          routes: {
            '/matchmaking': (_) => const Text("Matchmaking Screen"),
          },
        ),
      ),
    );

    await tester.pumpAndSettle();

    // Update this part: Make sure to use the correct key or type for the button
    await tester.tap(find.byKey(ValueKey('navigateButton'))); // Assuming you have a key on your button
    await tester.pumpAndSettle();

    expect(find.text("Matchmaking Screen"), findsOneWidget);
  });
}
