import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class UserRepository {
  final userCollection = Firestore.instance.collection('users');

  Future<List<User>> getAllData() async {
    List<User> users = [];
    await userCollection
        .getDocuments()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.documents.forEach((ds) {
            users.add(User.fromDocumentSnapshot(ds));
          });
        });

    return users;
  }

  Future<void> createUser({
    @required name,
    @required email,
    @required role,
    @required password,
  }) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser firebaseUser = (await _auth.createUserWithEmailAndPassword(
      email: email,
      password: 'a password',
    )).user;

    User user = User(
      name: name,
      email: email,
      role: role 
    );
    await userCollection.document(firebaseUser.uid).setData(user.toDocument());
  }

  Future<void> updateUser({
    @required User user
  }) async {
    await userCollection.document(user.id).updateData(user.toDocument());
  }

  Future<void> deleteUser(User user) async {
    return userCollection.document(user.id).delete();
  }
}