import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class UserRepository {
  final userCollection = Firestore.instance.collection('users');

  Future<List<User>> getAllData([includeDeleted = false]) async {
    List<User> users = [];
    QuerySnapshot snapshot;
    if(!includeDeleted) {
      snapshot = await userCollection.where('deleted', isEqualTo: false).getDocuments();
    } else {
      snapshot = await userCollection.getDocuments();
    }
    snapshot.documents.forEach((ds) {
      users.add(User.fromDocumentSnapshot(ds));
    });
    
    return users;
  }

  Future<User> getUser({@required uid}) async {
    DocumentSnapshot ds = await userCollection.document(uid).get();
    User user = User.fromDocumentSnapshot(ds);
    return user;
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
      password: password,
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
    await userCollection
        .document(user.id)
        .updateData(user.toDocument());
  }

  Future<void> deleteUser(User user) async {
    // return userCollection.document(user.id).delete();
    user.deleted = true;
    await userCollection
        .document(user.id)
        .updateData(user.toDocument());
  }
}