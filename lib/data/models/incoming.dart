import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/data/data.dart';

class Incoming {
  String id;
  int amount;
  DateTime date;
  Item item;
  Supplier supplier;

  Incoming({
    this.id,
    this.amount,
    this.date,
    this.item,
    this.supplier,
  });

  factory Incoming.fromMap(Map<String, dynamic> map) {
    return Incoming(
      id: map['id'],
      amount: map['amount'],
      date: map['date'] is Timestamp? map['date'].toDate() : map['date'] as DateTime,
      item: map['item'],
      supplier: map['supplier'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'amount': this.amount,
      'date': this.date,
      'item': this.item.toMap(),
      'supplier': this.supplier.toMap(),
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'amount': this.amount,
      'date': this.date,
      'item_id': this.item.id,
      'supplier_id': this.supplier.id,
    };
  }
}