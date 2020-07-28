import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/data/data.dart';

class Supplier {
  String id;
  String name;
  String phone;
  String address;

  Supplier({
    this.id,
    this.name,
    this.phone,
    this.address
  });

  factory Supplier.fromMap(Map<String, dynamic> map) {
    return Supplier(
      id: map['id'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
    );
  }

  factory Supplier.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Supplier(
      id: ds.documentID,
      name: ds.data['name'],
      phone: ds.data['phone'],
      address: ds.data['address'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'phone': this.phone,
      'address': this.address
    };
  }
}