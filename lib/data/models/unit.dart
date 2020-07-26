import 'package:inventoryapp/data/data.dart';

class Unit {
  String id;
  String name;

  Unit({
    this.id,
    this.name,
  });

  factory Unit.fromMap(Map<String, dynamic> map) {
    return Unit(
      id: map['id'],
      name: map['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name
    };
  }
}