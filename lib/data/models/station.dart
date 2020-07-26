import 'package:inventoryapp/data/data.dart';

class Station {
  String id;
  String name;

  Station({
    this.id,
    this.name,
  });

  factory Station.fromMap(Map<String, dynamic> map) {
    return Station(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
    };
  }

}