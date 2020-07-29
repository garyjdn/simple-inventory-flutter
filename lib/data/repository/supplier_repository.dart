import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class SupplierRepository {
  final supplierCollection = Firestore.instance.collection('suppliers');
  Future<List<Supplier>> getAllData() async {
    List<Supplier> suppliers = [];
    await supplierCollection
        .getDocuments()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.documents.forEach((ds) {
            suppliers.add(Supplier.fromDocumentSnapshot(ds));
          });
        });

    return suppliers;
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
    await supplierCollection.document(supplier.id).updateData(supplier.toDocument());
  }

  Future<void> deleteSupplier(Supplier supplier) async {
    return supplierCollection.document(supplier.id).delete();
  }
}
