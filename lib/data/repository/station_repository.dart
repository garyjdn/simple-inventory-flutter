import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class StationRepository {
  final stationCollection = Firestore.instance.collection('stations');
  Future<List<Station>> getAllData() async {
    List<Station> stations = [];
    await stationCollection
        .getDocuments()
        .then((QuerySnapshot querySnapshot) {
          querySnapshot.documents.forEach((ds) {
            stations.add(Station.fromDocumentSnapshot(ds));
          });
        });

    return stations;
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
    await stationCollection.document(station.id).updateData(station.toDocument());
  }

  Future<void> deleteStation(Station station) async {
    return stationCollection.document(station.id).delete();
  }
}