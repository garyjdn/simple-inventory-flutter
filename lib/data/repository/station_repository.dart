import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class StationRepository {
  final stationCollection = Firestore.instance.collection('stations');
  Future<List<Station>> getAllData([includeDeleted = false]) async {
    List<Station> stations = [];
    QuerySnapshot snapshot;
    if(!includeDeleted) {
      snapshot = await stationCollection.where('deleted', isEqualTo: false).getDocuments();
    } else {
      snapshot = await stationCollection.getDocuments();
    }

    snapshot.documents.forEach((ds) {
      stations.add(Station.fromDocumentSnapshot(ds));
    });

    return stations;
  }

  Future<Station> getStation({@required uid}) async {
    assert(uid != null);
    DocumentSnapshot ds = await stationCollection.document(uid).get(); 
    Station station = Station.fromDocumentSnapshot(ds);

    return station; 
  }

  Future<void> createStation({
    @required name,
  }) async {
    Station station = Station(
      name: name,
    );
    await stationCollection.add(station.toDocument());
  }

  Future<void> updateStation({
    @required Station station
  }) async {
    await stationCollection
        .document(station.id)
        .updateData(station.toDocument());
  }

  Future<void> deleteStation(Station station) async {
    // return stationCollection.document(station.id).delete();
    station.deleted = true;
    await stationCollection
        .document(station.id)
        .updateData(station.toDocument());
  }
}