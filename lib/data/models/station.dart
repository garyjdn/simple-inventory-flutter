import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Station extends Equatable {
  String id;
  String name;
  bool deleted;

  Station({
    this.id,
    this.name,
    this.deleted = false,
  });

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      id: map['id'],
      name: map['name'],
      deleted: map['deleted']
    );
  }

  factory Station.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Station(
      id: ds.documentID,
      name: ds.data['name'],
      deleted: ds.data['deleted']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'deleted': this.deleted
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': this.name,
      'deleted': this.deleted
    };
  }

  @override
  List<Object> get props => [id, name];

}