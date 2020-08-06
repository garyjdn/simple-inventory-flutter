import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';

class IncomingRepository {
  final incomingCollection = Firestore.instance.collection('incomings');
  Future<List<Incoming>> getAllData() async {
    List<Incoming> incomings = [];
    SupplierRepository categoryRepository = SupplierRepository();
    ItemRepository itemRepository = ItemRepository();
    QuerySnapshot querySnapshot = await incomingCollection.getDocuments();

    await Future.forEach(querySnapshot.documents, (DocumentSnapshot ds) async {
      Supplier supplier = await categoryRepository.getSupplier(uid: ds.data['supplier_id']);
      Item item = await itemRepository.getItem(uid: ds.data['item_id']);

      incomings.add(Incoming.fromMap({
        'id': ds.documentID,
        'amount': ds.data['amount'],
        'date': ds.data['date'],
        'supplier': supplier,
        'item': item
      }));
    });


    return incomings;
  }

  Future<void> createIncoming({
    @required DateTime date,
    @required Supplier supplier,
    @required Item item,
    @required int amount,
  }) async {
    assert(amount != null && amount > 0);
    Incoming incoming = Incoming(
      date: date,
      supplier: supplier,
      item: item,
      amount: amount
    );
    await incomingCollection.add(incoming.toDocument());
  }

  Future<void> updateIncoming({
    @required Incoming incoming
  }) async {
    await incomingCollection.document(incoming.id).updateData(incoming.toDocument());
  }

  Future<void> deleteIncoming(Incoming incoming) async {
    return incomingCollection.document(incoming.id).delete();
  }
}