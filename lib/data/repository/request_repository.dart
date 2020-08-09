import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class RequestRepository {
  final requestCollection = Firestore.instance.collection('requests');
  Future<List<RequestItem>> getAllData() async {
    List<RequestItem> requests = [];

    UserRepository userRepository = UserRepository();
    StationRepository stationRepository = StationRepository();
    QuerySnapshot querySnapshot = await requestCollection.getDocuments();

    await Future.forEach(querySnapshot.documents, (DocumentSnapshot ds) async {
      User requestUser = await userRepository.getUser(uid: ds.data['request_user']);
      Station station = await stationRepository.getStation(uid: ds.data['station_id']);

      requests.add(RequestItem.fromMap({
        'id': ds.documentID,
        'date': ds.data['date'],
        'request_user': requestUser,
        'station': station,
        'status': ds.data['status']
      }));
    });

    return requests;
  }

  // Future<Map<String, dynamic>> getRequestItem({@required uid}) async {
  //   assert(uid != null);
  //   DocumentSnapshot ds = await requestCollection.document(uid).get(); 
  //   RequestItem request = RequestItem.fromDocumentSnapshot(ds);

  //   RequestDetailRepository requestDetailRepository = RequestDetailRepository();
  //   List<RequestItemDetail> requestItemDetails = await requestDetailRepository.getRequestDetailByRequestId(request);

  //   return {
  //     'request': request,
  //     'detail': requestItemDetails
  //   }; 
  // }

  Future<void> createRequestItem({
    @required User user,
  }) async {
    RequestItem request = RequestItem(
      date: DateTime.now(),
      requestUser: user,
      status: 'Waiting'
    );
    await requestCollection.add(request.toDocument());
  }

  Future<void> updateRequestItem({
    @required RequestItem request
  }) async {
    await requestCollection.document(request.id).updateData(request.toDocument());
  }

  Future<void> deleteRequestItem(RequestItem request) async {
    return requestCollection.document(request.id).delete();
  }
}