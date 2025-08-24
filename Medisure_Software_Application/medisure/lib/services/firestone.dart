import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fst;
import 'usermodel.dart';

class FirestoreService {
  final CollectionReference<Map<String, dynamic>> _users =
      FirebaseFirestore.instance.collection('users');
  final fst.FirebaseStorage _storage = fst.FirebaseStorage.instance;

  Future<void> addUser(
    String email,
    String name,
    String ailments,
    String age,
    String gender,
    String photoUrl,
  ) {
    return _users.doc(email).set({
      'name': name,
      'ailments': ailments,
      'age': age,
      'gender': gender,
      'photoUrl': photoUrl,
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUserStream() =>
      _users.orderBy('age', descending: true).snapshots();

  Future<void> updateUser(
    String email,
    String name,
    String ailments,
    String age,
    String gender,
    String photoUrl,
  ) {
    return _users.doc(email).update({
      'name': name,
      'age': age,
      'ailments': ailments,
      'gender': gender,
      'photoUrl': photoUrl,
    });
  }

  Future<void> deleteUser(String email) => _users.doc(email).delete();

  Future<String> uploadProfileImage(String email, File file) async {
    final ref = _storage.ref('users/$email/profile.jpg');
    await ref.putFile(file, fst.SettableMetadata(contentType: 'image/jpeg'));
    return ref.getDownloadURL();
  }

  Future<User> getUser(String email) async {
    final doc = await _users.doc(email).get();
    if (doc.exists) {
      return User.fromFirestore(doc.data()!);
    }
    return User(
      email: email,
      name: '',
      gender: '',
      ailments: '',
      age: 0,
      photoUrl: '',
    );
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUserStreamByEmail(
          String email) =>
      _users.doc(email).snapshots();
}
