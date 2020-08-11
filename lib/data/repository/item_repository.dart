import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';

class ItemRepository {
  final itemCollection = Firestore.instance.collection('items');
  Future<List<Item>> getAllData([includeDeleted = false]) async {
    List<Item> items = [];
    CategoryRepository categoryRepository = CategoryRepository();
    UnitRepository unitRepository = UnitRepository();
    QuerySnapshot querySnapshot;
    if(!includeDeleted) {
      querySnapshot = await itemCollection.where('deleted', isEqualTo: false).getDocuments();
    } else {
      querySnapshot = await itemCollection.getDocuments();
    }

    await Future.forEach(querySnapshot.documents, (ds) async {
      Category category = await categoryRepository.getCategory(uid: ds.data['category_id']);
      Unit unit = await unitRepository.getUnit(uid: ds.data['unit_id']);

      items.add(Item.fromMap({
        'id': ds.documentID,
        'name': ds.data['name'],
        'category': category,
        'unit': unit
      }));
    });


    return items;
  }

  Future<Item> getItem({@required uid}) async {
    assert(uid != null);
    DocumentSnapshot ds = await itemCollection.document(uid).get(); 
    Item item = Item.fromDocumentSnapshot(ds);

    UnitRepository unitRepository = UnitRepository();
    Unit unit = await unitRepository.getUnit(uid: ds.data['unit_id']);

    CategoryRepository categoryRepository = CategoryRepository();
    Category category = await categoryRepository.getCategory(uid: ds.data['category_id']);

    item.unit = unit;
    item.category = category;

    return item; 
  }

  Future<void> createItem({
    @required name,
    @required category,
    @required unit,
  }) async {
    Item item = Item(
      name: name,
      category: category,
      unit: unit
    );
    await itemCollection.add(item.toDocument());
  }

  Future<void> updateItem({
    @required Item item
  }) async {
    await itemCollection
        .document(item.id)
        .updateData(item.toDocument());
  }

  Future<void> deleteItem(Item item) async {
    // return itemCollection.document(item.id).delete();
    item.deleted = true;
    await itemCollection
        .document(item.id)
        .updateData(item.toDocument());
  }
}
