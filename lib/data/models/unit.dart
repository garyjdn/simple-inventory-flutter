import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inventoryapp/data/data.dart';

class Unit extends Equatable{
  String id;
  String name;
  bool deleted;

  Unit({
    this.id,
    this.name,
    this.deleted = false,
  });

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'],
      name: map['name'],
      deleted: map['deleted'],
    );
  }

  factory Unit.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Unit(
      id: ds.documentID,
      name: ds.data['name'],
      deleted: ds.data['deleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'deleted': this.deleted,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': this.name,
      'deleted': this.deleted,
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, name];
}