import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/data/data.dart';

class RequestItemDetail {
  String id;
  Item item;
  RequestItem requestItem;
  int amount;
  bool deleted;

  RequestItemDetail({
    this.id,
    this.item,
    this.requestItem,
    this.amount,
    this.deleted = false,
  }):
    assert(item != null),
    assert(requestItem != null);

  factory RequestItemDetail.fromMap(Map<String, dynamic> map) {
    return RequestItemDetail(
      id: map['id'],
      requestItem: map['request_item'],
      item: map['item'],
      amount: map['amount'],
      deleted: map['deleted']
    );
  }

  factory RequestItemDetail.fromDocumentSnapshot(DocumentSnapshot ds) {
    return RequestItemDetail(
      id: ds.documentID,
      amount: ds.data['amount'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'amount': this.amount,
      'item_id': this.item.id,
      'request_id': this.requestItem.id,
    };
  }

}