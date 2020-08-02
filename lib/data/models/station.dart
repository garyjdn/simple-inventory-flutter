import 'package:cloud_firestore/cloud_firestore.dart';

class Station {
  String id;
  String name;

  Station({
    this.id,
    this.name,
  });

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      id: map['id'],
      name: map['name'],
    );
  }

  factory Station.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Station(
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