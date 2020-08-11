import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class SupplierRepository {
  final supplierCollection = Firestore.instance.collection('suppliers');
  Future<List<Supplier>> getAllData([includeDeleted = false]) async {
    List<Supplier> suppliers = [];
    QuerySnapshot snapshot;
    if(!includeDeleted) {
      snapshot = await supplierCollection.where('deleted', isEqualTo: false).getDocuments();
    } else {
      snapshot = await supplierCollection.getDocuments();
    }
    snapshot.documents.forEach((ds) {
      suppliers.add(Supplier.fromDocumentSnapshot(ds));
    });
    return suppliers;
  }

  Future<Supplier> getSupplier({@required uid}) async {
    assert(uid != null);
    DocumentSnapshot ds = await supplierCollection.document(uid).get(); 
    Supplier supplier = Supplier.fromDocumentSnapshot(ds); 
    return supplier; 
  }

  Future<void> createSupplier({
    @required name,
    @required phone,
    @required address,
  }) async {
    Supplier supplier = Supplier(
      name: name,
      phone: phone,
      address: address 
    );
    await supplierCollection.add(supplier.toDocument());
        // .document()
        // .setData({ 
        //   'name': supplier.name, 
        //   'phone': supplier.phone,
        //   'address': supplier.address,
        // });
  }

  Future<void> updateSupplier({
    @required Supplier supplier
  }) async {
    await supplierCollection
        .document(supplier.id)
        .updateData(supplier.toDocument());
  }

  Future<void> deleteSupplier(Supplier supplier) async {
    // return supplierCollection.document(supplier.id).delete();
    supplier.deleted = true;
    await supplierCollection
        .document(supplier.id)
        .updateData(supplier.toDocument());
  }
}
