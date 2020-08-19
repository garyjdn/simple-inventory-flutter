import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  String id;
  String name;
  String image;
  String email;
  String role;
  bool deleted;

  User({
    this.id,
    this.name,
    this.image,
    this.email,
    this.role,
    this.deleted = false,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      email: map['email'],
      role: map['role'],
      deleted: map['deleted'],
    );
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot ds) {
    return User(
      id: ds.documentID,
      name: ds.data['name'],
      image: ds.data['image'],
      email: ds.data['email'],
      role: ds.data['role'],
      deleted: ds.data['deleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'image': this.image,
      'email': this.email,
      'role': this.role,
      'deleted': this.deleted,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': this.name,
      'image': this.image ?? "",
      'email': this.email,
      'role': this.role,
      'deleted': this.deleted,
    };
  }

  @override
  List<Object> get props => [id];
}