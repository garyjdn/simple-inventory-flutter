import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class UnitRepository {
  final unitCollection = Firestore.instance.collection('units');
  Future<List<Unit>> getAllData() async {
    List<Unit> units = [];
    await unitCollection
        .getDocuments()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.documents.forEach((ds) {
            units.add(Unit.fromDocumentSnapshot(ds));
          });
        });

    return units;
  }

  Future<void> createUnit({
    @required name,
  }) async {
    Unit unit = Unit(
      name: name,
    );
    await unitCollection.add(unit.toDocument());
  }

  Future<void> updateUnit({
    @required Unit unit
  }) async {
    await unitCollection.document(unit.id).updateData(unit.toDocument());
  }

  Future<void> deleteUnit(Unit unit) async {
    return unitCollection.document(unit.id).delete();
  }
}
