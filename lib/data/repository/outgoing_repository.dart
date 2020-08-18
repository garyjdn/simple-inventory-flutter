import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';

class OutgoingRepository {
  final outgoingCollection = Firestore.instance.collection('outgoings');
  Future<List<Outgoing>> getAllData([includeDeleted = false]) async {
    List<Outgoing> outgoings = [];
    UserRepository categoryRepository = UserRepository();
    ItemRepository itemRepository = ItemRepository();
    StationRepository stationRepository = StationRepository();
    QuerySnapshot querySnapshot;
    if(!includeDeleted) {
      querySnapshot = await outgoingCollection
          .where('deleted', isEqualTo: false)
          .orderBy('created_at', descending: true)
          .getDocuments();
    } else {
      querySnapshot = await outgoingCollection
          .orderBy('created_at', descending: true)
          .getDocuments();
    }

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
        'station': station,
        'deleted': ds.data['deleted'],
      }));
    });


    return outgoings;
  }

  Future<List<Outgoing>> getAllDataFilteredByDate(DateTime startDate, DateTime endDate) async {
    List<Outgoing> outgoings = [];
    QuerySnapshot querySnapshot = await outgoingCollection
        .where('deleted', isEqualTo: false)
        .where('date', isGreaterThanOrEqualTo: startDate)
        .where('date', isLessThan: DateTime(endDate.year, endDate.month, endDate.day + 1))
        .orderBy('date')
        .getDocuments();

    UserRepository userRepository = UserRepository();
    List<User> users = await userRepository.getAllData(true);

    ItemRepository itemRepository = ItemRepository();
    List<Item> items = await itemRepository.getAllData(true);

    StationRepository stationRepository = StationRepository();
    List<Station> stations = await stationRepository.getAllData(true);

    await Future.forEach(querySnapshot.documents, (DocumentSnapshot ds) async {
      User user = users.firstWhere((User e) => e.id == ds.data['user_id']);
      Item item = items.firstWhere((Item e) => e.id == ds.data['item_id']);
      Station station = stations.firstWhere((Station e) => e.id == ds.data['station_id']);

      outgoings.add(Outgoing.fromMap({
        'id': ds.documentID,
        'amount': ds.data['amount'],
        'date': ds.data['date'],
        'user': user,
        'item': item,
        'station': station,
        'deleted': ds.data['deleted'],
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
    await outgoingCollection
        .document(outgoing.id)
        .updateData(outgoing.toDocument());
  }

  Future<void> deleteOutgoing(Outgoing outgoing) async {
    // return outgoingCollection.document(outgoing.id).delete();
    outgoing.deleted = true;
    await outgoingCollection
        .document(outgoing.id)
        .updateData(outgoing.toDocument());
  }
}
