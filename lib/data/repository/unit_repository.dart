import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class UnitRepository {
  final unitCollection = Firestore.instance.collection('units');
  Future<List<Unit>> getAllData([includeDeleted = false]) async {
    List<Unit> units = [];
    QuerySnapshot snapshot;
    if(!includeDeleted) {
      snapshot = await unitCollection.where('deleted', isEqualTo: false).getDocuments();
    } else {
      snapshot = await unitCollection.getDocuments();
    }

    snapshot.documents.forEach((ds) {
      units.add(Unit.fromDocumentSnapshot(ds));
    });

    return units;
  }

  Future<Unit> getUnit({@required uid}) async { 
    DocumentSnapshot ds = await unitCollection.document(uid).get(); 
    Unit unit = Unit.fromDocumentSnapshot(ds); 
    return unit; 
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
    await unitCollection
        .document(unit.id)
        .updateData(unit.toDocument());
  }

  Future<void> deleteUnit(Unit unit) async {
    // return unitCollection.document(unit.id).delete();
    unit.deleted = true;
    await unitCollection
        .document(unit.id)
        .updateData(unit.toDocument());
  }
}
