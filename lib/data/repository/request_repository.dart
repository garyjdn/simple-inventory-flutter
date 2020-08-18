import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class RequestRepository {
  final requestCollection = Firestore.instance.collection('requests');
  Future<List<RequestItem>> getAllData(User user, [includeDeleted = false]) async {
    List<RequestItem> requests = [];

    QuerySnapshot querySnapshot;
    UserRepository userRepository = UserRepository();
    StationRepository stationRepository = StationRepository();
    if(!includeDeleted) {
      querySnapshot = await requestCollection
        .where('deleted', isEqualTo: false)
        .orderBy('date', descending: true)
        .getDocuments();
    } else {
      querySnapshot = await requestCollection
        .orderBy('date', descending: true)
        .getDocuments();
    }

    List<User> users = await userRepository.getAllData(true);
    List<Station> stations = await stationRepository.getAllData(true);

    await Future.forEach(querySnapshot.documents, (DocumentSnapshot ds) async {
      User requestUser = users.firstWhere((User e) => e.id == ds.data['request_user']);
      Station station = stations.firstWhere((Station e) => e.id == ds.data['station_id']);
      if(user.role != 'Staff' || (requestUser.role == 'Staff' && user.id == requestUser.id)) {
        requests.add(RequestItem.fromMap({
          'id': ds.documentID,
          'date': ds.data['date'],
          'request_user': requestUser,
          'station': station,
          'status': ds.data['status'],
          'deleted': ds.data['deleted'],
        }));
      }
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

  Future<RequestItem> createRequestItem({
    @required Station station,
    @required User user,
  }) async {
    RequestItem request = RequestItem(
      date: DateTime.now(),
      requestUser: user,
      station: station,
      status: 'Waiting'
    );
    DocumentReference documentReference = await requestCollection.add(request.toDocument());
    request.id = documentReference.documentID;

    return request;
  }

  Future<void> updateRequestItem({
    @required RequestItem request
  }) async {
    await requestCollection
        .document(request.id)
        .updateData(request.toDocument());
  }

  Future<void> deleteRequestItem(RequestItem request) async {
    // return requestCollection.document(request.id).delete();
    request.deleted = true;
    await requestCollection
        .document(request.id)
        .updateData(request.toDocument());
  }
}