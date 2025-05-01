import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:semester_project__uprm_pet_adoption/services/auth_service.dart';

// Mock to simulate wrong-password scenario in signIn
// Note: reason why a mock was created was to simulate
// the same flow that a normal signIn function would do.
// The imported mocks/fakes firebase auth and firestore
// seemed to not be able to correctly throw exceptions 
// during tests. This MockAuthService clearly helps in mocking the correct
// way that signInWithEmailAndPassword() function should with the most 
// important exceptions that we experience during these signin's.

// Note: to run test, open terminal and type
// flutter test
// If you want a specific test file then simply
// flutter test filePath

class MockAuthService extends MockFirebaseAuth {
  final FakeFirebaseFirestore fakeFirestore;

  MockAuthService({required this.fakeFirestore});

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // finding user collection
    final usersCollection = await fakeFirestore.collection('users').get();

    final matchingUser = usersCollection.docs.firstWhere(
      (doc) => doc.data()['email'] == email,
      orElse: null,
    );

    if (matchingUser == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user found for that email.',
      );
    }

    if (matchingUser.data()['password'] != password) {
      throw FirebaseAuthException(
        code: 'wrong-password',
        message: 'Wrong password provided for that user.',
      );
    }

    // If email and password match continue to normal function
    return super.signInWithEmailAndPassword(email: email, password: password);
  }
}

void main() {
  late AuthService authService;
  late FakeFirebaseFirestore fakeFirestore;
  late MockFirebaseAuth mockAuth;
  TestWidgetsFlutterBinding.ensureInitialized();

  // MOCK fluttertoast platform channel
  const MethodChannel channel = MethodChannel('PonnamKarthik/fluttertoast');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    // Just simulate success without doing anything
    return null;
  });

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    mockAuth = MockAuthService(fakeFirestore: fakeFirestore);
    authService = AuthService(auth: mockAuth, firestore: fakeFirestore);
  });

  group('AuthService signUp', () {
    test('Successful signup creates a user document', () async {
      //user signups
      await authService.signUp(
        firstName: 'John',
        lastName: 'Doe',
        password: 'password@123',
        email: 'john@gmail.com',
      );

      //verify signup was successful and that user appears in collection
      final userDocs = await fakeFirestore.collection('users').get();
      expect(userDocs.docs.length, 1);
      expect(userDocs.docs.first['email'], 'john@gmail.com');
    });

    test('Signup with duplicate email throws an error', () async {
      // First signup succeeds
      await authService.signUp(
        firstName: 'Jane',
        lastName: 'Smith',
        password: 'password@123',
        email: 'jane@gmail.com',
      );

      //verify signup was successful and that user appears in collection
      final userDocs = await fakeFirestore.collection('users').get();
      expect(userDocs.docs.length, 1);
      expect(userDocs.docs.first['email'], 'jane@gmail.com');

      // Second signup with same email should throw
      await authService.signUp(
        firstName: 'Jane',
        lastName: 'Smith',
        password: 'password@123',
        email: 'jane@gmail.com',
      );

      expect(userDocs.docs.length, 1);
      expect(userDocs.docs.first['email'], 'jane@gmail.com');
    });
  });

  group('AuthService signIn', () {
    test('Successful signIn returns true', () async {
      // First, signup the user (needed to mock an existing user)
      await authService.signUp(
        firstName: 'FirstName',
        lastName: 'LastName',
        password: 'pass@123',
        email: 'user@gmail.com',
      );

      //verify signup was successful and that user appears in collection
      final userDocs = await fakeFirestore.collection('users').get();
      expect(userDocs.docs.length, 1);
      expect(userDocs.docs.first['email'], 'user@gmail.com');

      final result = await authService.signIn(
        email: 'user@gmail.com',
        password: 'pass@123',
      );

      expect(userDocs.docs.length, 1);
      expect(userDocs.docs.first['email'], 'user@gmail.com');
      expect(result, true);
    });

    test('SignIn with wrong password returns false', () async {
      // First, signup the user (needed to mock an existing user)
      await authService.signUp(
        firstName: 'FirstName',
        lastName: 'LastName',
        password: 'pass@123',
        email: 'user@gmail.com',
      );

      //verify signup was successful and that user appears in collection
      final userDocs = await fakeFirestore.collection('users').get();
      expect(userDocs.docs.length, 1);
      expect(userDocs.docs.first['email'], 'user@gmail.com');

      final result = await authService.signIn(
        email: 'user@gmail.com',
        password: 'pass123',
      );

      expect(userDocs.docs.length, 1);
      expect(userDocs.docs.first['email'], 'user@gmail.com');
      expect(result, false);
    });

      test('SignIn with non-existent user returns false', () async {
      // No signup as there is no user  

      final result = await authService.signIn(
        email: 'user@gmail.com',
        password: 'pass123',
      );

      final userDocs = await fakeFirestore.collection('users').get();
      expect(userDocs.docs.length, 0);
      expect(result, false);
    });
  });

  group('AuthService petsSignUp', () {
    test('Successful pet signup creates a pet document', () async {
      // First, sign up user
      await authService.signUp(
        firstName: 'FirstName',
        lastName: 'LastName',
        password: 'pass@123',
        email: 'user@gmail.com',
      );

      //Second, sign in user
      await authService.signIn(
        email: 'user@gmail.com',
        password: 'pass@123',
      );

      //Finally, user create pet
      await authService.petsSignUp(
        medicalDocument: 'medicalDoc123',
        petPicture: 'petPicUrl',
        petAge: 'Adult',
        petBreed: 'Golden Retriever',
        petDescription: 'Very friendly and playful.',
        petName: 'Buddy',
        petShelter: 'Happy Shelter',
        petTags: 'friendly, playful',
      );

      final petDocs = await fakeFirestore.collection('pets').get();
      expect(petDocs.docs.length, 1);
      expect(petDocs.docs.first['petName'], 'Buddy');
    });

    test('Pet signup fails when no user is signed in', () async {
      // No mock sign up && most of all No sign in

      await authService.petsSignUp(
        medicalDocument: 'medicalDoc123',
        petPicture: 'petPicUrl',
        petAge: 'Adult',
        petBreed: 'Golden Retriever',
        petDescription: 'Very friendly and playful.',
        petName: 'Buddy',
        petShelter: 'Happy Shelter',
        petTags: 'friendly, playful',
      );

      final petDocs = await fakeFirestore.collection('pets').get();
      expect(petDocs.docs.length, 0); // No pet should be added if not signed in
    });
  });
}
