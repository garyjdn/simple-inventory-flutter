import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/data/data.dart';

class Category {
  String id;
  String name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
    );
  }

  factory Category.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Category(
      id: ds.documentID,
      name: ds.data['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': this.name,
    };
  }
}