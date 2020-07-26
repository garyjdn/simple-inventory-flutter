import 'package:inventoryapp/data/data.dart';

class Category {
  String id;
  String name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
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