import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/data/data.dart';

class Outgoing {
  String id;
  int amount;
  DateTime date;
  Item item;
  Station station;
  User user;
  bool deleted;
  DateTime createdAt;

  Outgoing({
    this.id,
    this.amount,
    this.date,
    this.item,
    this.station,
    this.user,
    this.deleted = false,
    createdAt
  }):
    createdAt = createdAt ?? DateTime.now();

  factory Outgoing.fromMap(Map<String,dynamic> map) {
    return Outgoing(
      id: map['id'],
      amount: map['amount'],
      date: map['date'] is Timestamp? map['date'].toDate() : map['date'] as DateTime,
      item: map['item'],
      station: map['station'],
      user: map['user'],
      deleted: map['deleted'],
      createdAt: map['created_at']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'amount': this.amount,
      'date': this.date,
      'item_id': this.item.toMap(),
      'station': this.station.toMap(),
      'user': this.user.toMap(),
      'deleted': this.deleted,
      'created_at': this.createdAt,
    };
  }

  Map<String, dynamic> toDocument() {
    return {
      'amount': this.amount,
      'date': this.date,
      'item_id': this.item.id,
      'station_id': this.station.id,
      'user_id': this.user.id,
      'deleted': this.deleted,
      'created_at': this.createdAt,
    };
  }
}