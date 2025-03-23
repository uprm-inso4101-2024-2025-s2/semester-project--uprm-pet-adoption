import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:semester_project__uprm_pet_adoption/models/user.dart';

const String USERS_COLLECTION_REF = "users";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _usersRef;

  // DatabaseService class to handle CRUD operations for users
  DatabaseService() {
    _usersRef = _firestore.collection(USERS_COLLECTION_REF).withConverter<User>(
        fromFirestore: (snapshots, _) => User.fromJson(
              snapshots.data()!,
            ),
        toFirestore: (user, _) => user.toJson());
  }

  // Retrieves a real-time stream of user documents
  Stream<QuerySnapshot> getUsers() {
    return _usersRef.snapshots();
  }

  // Adds a new user to Firestore
  void addUser(User user) async {
    _usersRef.add(user);
  }

  // Updates an existing user identified by userId
  void updateUser(String userId, User user) {
    _usersRef.doc(userId).update(user.toJson());
  }

  // Deletes a user document identified by userId
  void deleteUser(String userId) {
    _usersRef.doc(userId).delete();
  }
}
