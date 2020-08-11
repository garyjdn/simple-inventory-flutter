import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inventoryapp/data/data.dart';

class Category extends Equatable{
  String id;
  String name;
  bool deleted;

  Category({
    this.id,
    this.name,
    this.deleted = false,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      name: map['name'],
      deleted: map['deleted'],
    );
  }

  factory Category.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Category(
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
      'deleted': this.deleted
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, name];
}