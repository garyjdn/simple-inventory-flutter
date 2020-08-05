import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/data/data.dart';

class Item {
  String id;
  String name;
  Category category;
  Unit unit;

  Item({
    this.id,
    this.name,
    this.category,
    this.unit,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      unit: map['unit'],
    );
  }

  factory Item.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Item(
      id: ds.documentID,
      name: ds.data['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'category': this.category.toMap(),
      'unit': this.unit.toMap(),
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': this.name,
      'category_id': this.category.id,
      'unit_id': this.unit.id
    };
  }
}