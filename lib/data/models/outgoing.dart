import 'package:inventoryapp/data/data.dart';

class Outgoing {
  String id;
  int amount;
  DateTime date;
  Item item;
  Station station;
  User user;

  Outgoing({
    this.id,
    this.amount,
    this.date,
    this.item,
    this.station,
    this.user,
  });

  factory Outgoing.fromMap(Map<String,dynamic> map) {
    return Outgoing(
      id: map['id'],
      amount: map['amount'],
      date: map['date'],
      item: map['item'],
      station: map['station'],
      user: map['user']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'amount': this.amount,
      'date': this.date,
      'item_id': this.item.toMap(),
      'station': this.station.toMap(),
      'user': this.user.toMap()
    };
  }

}