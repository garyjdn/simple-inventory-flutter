import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';

class OutgoingRepository {
  final outgoingCollection = Firestore.instance.collection('outgoings');
  Future<List<Outgoing>> getAllData() async {
    List<Outgoing> outgoings = [];
    UserRepository categoryRepository = UserRepository();
    ItemRepository itemRepository = ItemRepository();
    StationRepository stationRepository = StationRepository();
    QuerySnapshot querySnapshot = await outgoingCollection.getDocuments();

    await Future.forEach(querySnapshot.documents, (DocumentSnapshot ds) async {
      User user = await categoryRepository.getUser(uid: ds.data['user_id']);
      Item item = await itemRepository.getItem(uid: ds.data['item_id']);
      Station station = await stationRepository.getStation(uid: ds.data['station_id']);

      outgoings.add(Outgoing.fromMap({
        'id': ds.documentID,
        'amount': ds.data['amount'],
        'date': ds.data['date'],
        'user': user,
        'item': item,
        'station': station 
      }));
    });


    return outgoings;
  }

  Future<List<Outgoing>> getAllDataFilteredByDate(DateTime startDate, DateTime endDate) async {
    List<Outgoing> outgoings = [];
    UserRepository categoryRepository = UserRepository();
    ItemRepository itemRepository = ItemRepository();
    StationRepository stationRepository = StationRepository();
    QuerySnapshot querySnapshot = await outgoingCollection
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThan: DateTime(endDate.year, endDate.month, endDate.day + 1))
        .orderBy('date')
        .getDocuments();

    await Future.forEach(querySnapshot.documents, (DocumentSnapshot ds) async {
      User user = await categoryRepository.getUser(uid: ds.data['user_id']);
      Item item = await itemRepository.getItem(uid: ds.data['item_id']);
      Station station = await stationRepository.getStation(uid: ds.data['station_id']);

      outgoings.add(Outgoing.fromMap({
        'id': ds.documentID,
        'amount': ds.data['amount'],
        'date': ds.data['date'],
        'user': user,
        'item': item,
        'station': station 
      }));
    });


    return outgoings;
  }

  Future<void> createOutgoing({
    @required DateTime date,
    @required User user,
    @required Item item,
    @required Station station,
    @required int amount,
  }) async {
    assert(amount != null && amount > 0);
    Outgoing outgoing = Outgoing(
      date: date,
      user: user,
      item: item,
      amount: amount,
      station: station
    );
    await outgoingCollection.add(outgoing.toDocument());
  }

  Future<void> updateOutgoing({
    @required Outgoing outgoing
  }) async {
    await outgoingCollection.document(outgoing.id).updateData(outgoing.toDocument());
  }

  Future<void> deleteOutgoing(Outgoing outgoing) async {
    return outgoingCollection.document(outgoing.id).delete();
  }
}
