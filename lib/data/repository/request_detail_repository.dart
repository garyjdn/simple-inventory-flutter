import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

class RequestDetailRepository {
  final requestItemCollection = Firestore.instance.collection('request_items');
  Future<List<RequestItemDetail>> getRequestDetailByRequestId({
    RequestItem requestItem,
    includeDeleted = false,
  }) async {
    List<RequestItemDetail> requestItems = [];

    ItemRepository itemRepository = ItemRepository();
    QuerySnapshot querySnapshot;

    if(!includeDeleted) {
      querySnapshot = await requestItemCollection
        .where('request_id', isEqualTo: requestItem.id)
        .where('deleted', isEqualTo: false)
        .getDocuments();
    } else {
      querySnapshot = await requestItemCollection
        .where('request_id', isEqualTo: requestItem.id)
        .getDocuments();
    }

    await Future.forEach(querySnapshot.documents, (DocumentSnapshot ds) async {
      Item item = await itemRepository.getItem(uid: ds.data['item_id']);

      requestItems.add(RequestItemDetail.fromMap({
        'id': ds.documentID,
        'item': item,
        'request_item': requestItem,
        'amount': ds.data['amount'],
        'deleted': ds.data['deleted'],
      }));
    });

    return requestItems;
  }

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
    await requestItemCollection
        .document(requestItemDetail.id)
        .updateData(requestItemDetail.toDocument());
  }

  Future<void> deleteRequestDetail(RequestItemDetail requestItemDetail) async {
    // return requestItemCollection.document(station.id).delete();
    requestItemDetail.deleted = true;
    await requestItemCollection
        .document(requestItemDetail.id)
        .updateData(requestItemDetail.toDocument());
  }
}