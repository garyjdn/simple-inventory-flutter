import 'package:inventoryapp/data/data.dart';

enum RequestStatus {
  REVIEW,
  ACCEPTED,
  REJECTED,
}

class RequestItem {
  String id;
  Item item;
  int amount;
  Station station;
  DateTime date;
  User userRequest;
  User userReview;
  RequestStatus requestStatus;

  RequestItem({
    this.id,
    this.item,
    this.amount,
    this.station,
    this.date,
    this.userRequest,
    this.userReview,
    status
  }) {
    assert(id != null);
    assert(status != null);
    this.requestStatus = stringStatusToEnum(status);
  }

  factory RequestItem.fromMap(Map<String, dynamic> map) {
    return RequestItem(
      id: map['id'],
      item: Item.fromMap(map['item']),
      amount: map['amount'],
      station: Station.fromMap(map['station']),
      date: map['date'],
      userRequest: User.fromMap(map['user_request']),
      userReview: User.fromMap(map['user_review']),
      status: map['status']
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'item': this.item.toMap(),
      'amount': this.amount,
      'station': this.station.toMap(),
      'date': this.date,
      'user_request': this.userRequest.toMap(),
      'user_review': this.userReview.toMap(),
      'status': requestStatusToString(this.requestStatus)
    };
  }

  RequestStatus stringStatusToEnum(String status) {
    RequestStatus requestStatus;
    if(status == "review")
      requestStatus = RequestStatus.REVIEW;
    else if(status == "accepted") 
      requestStatus = RequestStatus.ACCEPTED;
    else if(status == "rejected")
      requestStatus = RequestStatus.REJECTED;

    assert(requestStatus != null);
    return requestStatus;
  }

  String requestStatusToString(RequestStatus requestStatus) {
    String status;
    switch (requestStatus) {
      case RequestStatus.REVIEW:
        status = "review";
        break;
      case RequestStatus.ACCEPTED:
        status = "accepted";
        break;
      case RequestStatus.REJECTED:
        status = "rejected";
        break;
    }
    assert(status != null);
    return status;
  }

}