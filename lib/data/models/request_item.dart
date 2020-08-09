import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventoryapp/data/data.dart';

enum RequestStatus {
  WAITING,
  APPROVED,
  REJECTED,
}

class RequestItem {
  String id;
  Station station;
  DateTime date;
  User requestUser;
  User reviewUser;
  RequestStatus requestStatus;

  RequestItem({
    this.id,
    this.station,
    this.date,
    this.requestUser,
    this.reviewUser,
    String status
  }) {
    assert(status != null);
    this.requestStatus = stringStatusToEnum(status);
  }

  factory RequestItem.fromMap(Map<String, dynamic> map) {
    return RequestItem(
      id: map['id'],
      station: map['station'],
      date: map['date'] is Timestamp? map['date'].toDate() : map['date'] as DateTime ,
      requestUser: map['request_user'],
      reviewUser: map['review_user'],
      status: map['status']
    );
  }

  factory RequestItem.fromDocumentSnapshot(DocumentSnapshot ds) {
    return RequestItem(
      id: ds.documentID,
      date: ds.data['date'] is Timestamp? ds.data['date'].toDate() : ds.data['date'] as DateTime,
      status: ds.data['status']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'station': this.station.toMap(),
      'date': this.date,
      'request_user': this.requestUser.toMap(),
      'review_user': this.reviewUser.toMap(),
      'status': this.requestStatus is String? this.requestStatus : requestStatusToString(this.requestStatus)
    };
  }

  RequestStatus stringStatusToEnum(String status) {
    RequestStatus requestStatus;
    if(status == "Waiting")
      requestStatus = RequestStatus.WAITING;
    else if(status == "Approved") 
      requestStatus = RequestStatus.APPROVED;
    else if(status == "Rejected")
      requestStatus = RequestStatus.REJECTED;

    assert(requestStatus != null);
    return requestStatus;
  }

  String requestStatusToString(RequestStatus requestStatus) {
    String status;
    switch (requestStatus) {
      case RequestStatus.WAITING:
        status = "Waiting";
        break;
      case RequestStatus.APPROVED:
        status = "Approved";
        break;
      case RequestStatus.REJECTED:
        status = "Rejected";
        break;
    }
    assert(status != null);
    return status;
  }

  Map<String, dynamic> toDocument() {
    return {
      'date': this.date,
      'station_id': this.station.id,
      'request_user': this.requestUser.id,
      'review_user': this.reviewUser?.id,
      'status': this.requestStatus is String? this.requestStatus : requestStatusToString(this.requestStatus)
    };
  }

}