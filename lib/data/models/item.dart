import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:inventoryapp/data/data.dart';

class Item extends Equatable{
  String id;
  String name;
  Category category;
  Unit unit;
  int stock;
  bool deleted;

  Item({
    this.id,
    this.name,
    this.category,
    this.unit,
    this.stock = 0,
    this.deleted = false,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      name: map['name'],
      category: map['category'],
      unit: map['unit'],
      stock: map['stock'],
      deleted: map['deleted']
    );
  }

  factory Item.fromDocumentSnapshot(DocumentSnapshot ds) {
    return Item(
      id: ds.documentID,
      name: ds.data['name'],
      stock: ds.data['stock'],
      deleted: ds.data['deleted']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'category': this.category.toMap(),
      'unit': this.unit.toMap(),
      'stock': this.stock,
      'deleted': this.deleted,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'name': this.name,
      'category_id': this.category.id,
      'unit_id': this.unit.id,
      'stock': this.stock,
      'deleted': this.deleted
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => [id, name];
}