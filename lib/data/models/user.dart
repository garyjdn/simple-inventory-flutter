import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  String id;
  String name;
  String image;
  String email;
  String role;

  User({
    this.id,
    this.name,
    this.image,
    this.email,
    this.role,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      email: map['email'],
      role: map['role']
    );
  }

  factory User.fromDocumentSnapshot(DocumentSnapshot ds) {
    return User(
      id: ds.documentID,
      name: ds.data['name'],
      image: ds.data['image'],
      email: ds.data['email'],
      role: ds.data['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'image': this.image,
      'email': this.email,
      'role': this.role,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': this.name,
      'image': this.image,
      'email': this.email,
      'role': this.role
    };
  }

  @override
  List<Object> get props => [id];
}