import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Supplier extends Equatable{
  String id;
  String name;
  String phone;
  String address;
  bool deleted;

  Supplier({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.deleted = false,
  });

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      deleted: map['deleted'],
    );
  }

  factory Supplier.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Supplier(
      id: ds.documentID,
      name: ds.data['name'],
      phone: ds.data['phone'],
      address: ds.data['address'],
      deleted: ds.data['deleted'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'phone': this.phone,
      'address': this.address,
      'deleted': this.deleted,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': this.name,
      'phone': this.phone,
      'address': this.address,
      'deleted': this.deleted,
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, name, phone, address];
}