import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/data/data.dart';

class Unit {
  String id;
  String name;

  Unit({
    this.id,
    this.name,
  });

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'],
      name: map['name'],
    );
  }

  factory Unit.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Unit(
      id: ds.documentID,
      name: ds.data['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': this.name,
    };
  }
}