import 'package:cloud_firestore/cloud_firestore.dart';

class UserFirestore {
  static const collection = 'users';

  static Future<void> createData(Map<String, dynamic> data) {
    return Firestore.instance.collection(collection).document().setData(data);
  }

  static Future<dynamic> getData(id) async {
    DocumentSnapshot ds = await Firestore.instance.collection(collection).document(id).get();
    return ds.data;
  }
}
