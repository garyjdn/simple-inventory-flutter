import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/data/data.dart';

class SupplierRepository {
  Future<List<Supplier>> getAllData() async {
    List<Supplier> suppliers = [];
    await Firestore.instance
        .collection('suppliers')
        .getDocuments()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.documents.forEach((ds) {
            suppliers.add(Supplier.fromDocumentSnapshot(ds));
          });
        });

    return suppliers;
  }
}
