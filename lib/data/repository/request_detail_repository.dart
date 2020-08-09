import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class RequestDetailRepository {
  final requestItemCollection = Firestore.instance.collection('request_items');
  Future<List<RequestItemDetail>> getRequestDetailByRequestId({
    RequestItem requestItem
  }) async {
    List<RequestItemDetail> requestItems = [];

    ItemRepository itemRepository = ItemRepository();
    QuerySnapshot querySnapshot = await requestItemCollection
        .where('request_id', isEqualTo: requestItem.id)
        .getDocuments();

    await Future.forEach(querySnapshot.documents, (DocumentSnapshot ds) async {
      Item item = await itemRepository.getItem(uid: ds.data['item_id']);

      requestItems.add(RequestItemDetail.fromMap({
        'id': ds.documentID,
        'item': item,
        'request_item': requestItem,
        'amount': ds.data['amount']
      }));
    });

    return requestItems;
  }

  // Future<RequestItemDetail> getRequestDetail({
  //   @required String uid, 
  //   RequestItem request,
  //   Item i,
  // }) async {
  //   assert(uid != null);
  //   DocumentSnapshot ds = await stationCollection.document(uid).get(); 
  //   RequestItemDetail requestItemDetail = RequestItemDetail.fromDocumentSnapshot(ds);

  //   RequestItem requestItem;
  //   if(request != null) {
  //     requestItem = request;
  //   } else {
  //     RequestRepository requestRepository = RequestRepository();
  //     requestItem = await requestRepository.getRequestItem(uid: ds.data['request_id']);
  //   }

  //   Item item;
  //   if(i != null) {
  //     item = i;
  //   } else {
  //     ItemRepository itemRepository = ItemRepository();
  //     item = await itemRepository.getItem(uid: ds.data['item_id']);
  //   }
    

  //   requestItemDetail.requestItem = requestItem;
  //   requestItemDetail.item = item;

  //   return requestItemDetail; 
  // }

  // Future<List<RequestItemDetail>> getRequestDetailByRequestId(
  //   RequestItem request
  // ) async {
  //   QuerySnapshot qs = await stationCollection
  //       .where('request_id', isEqualTo: request.id)
  //       .getDocuments(); 

  //   List<RequestItemDetail> requestItemDetails = qs.documents.map((ds) => RequestItemDetail.fromDocumentSnapshot(ds)).toList();

  //   return requestItemDetails;
  // }

  Future<void> createRequestDetail({
    @required RequestItem requestItem,
    @required Item item,
    @required int amount,
  }) async {
    RequestItemDetail requestItemDetail = RequestItemDetail(
      requestItem: requestItem,
      item: item,
      amount: amount
    );
    await requestItemCollection.add(requestItemDetail.toDocument());
  }

  Future<void> updateRequestDetail({
    @required RequestItemDetail requestItemDetail
  }) async {
    await requestItemCollection.document(requestItemDetail.id).updateData(requestItemDetail.toDocument());
  }

  Future<void> deleteRequestDetail(RequestItemDetail station) async {
    return requestItemCollection.document(station.id).delete();
  }
}