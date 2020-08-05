import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<bool> hasToken() async {
    return await AuthSharedPref.hasCache();
  }

  Future<void> persistToken(data, {expiry: const Duration(hours: 23)}) async {
    return await AuthSharedPref.createData(data, expiry: expiry);
  }

  Future<dynamic> getAuthenticatedData() async {
    var data = await AuthSharedPref.readData();
    return data;
  }

  Future<dynamic> login({
    @required String email,
    @required String password,
  }) async {
    assert(email != null || email.isNotEmpty);
    assert(password != null || password.isNotEmpty);

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final FirebaseUser firebaseUser = (await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    ))
        .user;

    Map<String, dynamic> userMap =
        await UserFirestore.getData(firebaseUser.uid);
    User user = User.fromMap(userMap)
      ..id = firebaseUser.uid;

    return user;
  }

  Future<void> logout() {}
}
