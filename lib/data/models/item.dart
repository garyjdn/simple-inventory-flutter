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
      category: Category.fromMap(map['category']),
      unit: Unit.fromMap(map['unit']),
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
}