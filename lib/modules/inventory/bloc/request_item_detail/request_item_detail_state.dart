part of 'request_item_detail_bloc.dart';

abstract class RequestItemDetailState extends Equatable {
  const RequestItemDetailState();
}

class RequestItemDetailInitial extends RequestItemDetailState {
  @override
  List<Object> get props => [];
}

class RequestItemDetailLoadStarted extends RequestItemDetailState {
  @override
  List<Object> get props => [];

}

class RequestItemDetailLoadSuccess extends RequestItemDetailState {
  final List<RequestItemDetail> requestItemDetails;
  final List<Item> items;

  RequestItemDetailLoadSuccess({
    @required this.requestItemDetails,
    @required this.items
  }):
    assert(requestItemDetails != null);

  @override
  List<Object> get props => [];
}

class RequestItemDetailLoadFailure extends RequestItemDetailState {
  final String title;
  final String message;

  RequestItemDetailLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class RequestItemDetailDeleteSuccess extends RequestItemDetailState {
  final String message;

  RequestItemDetailDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}

class RequestItemDetailSubmitInProgress extends RequestItemDetailState {
  @override
  List<Object> get props => [];
}

class RequestItemDetailSubmitSuccess extends RequestItemDetailState {
  final String message;

  RequestItemDetailSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}

class RequestItemDetailSubmitStatusSuccess extends RequestItemDetailState {
  final String message;

  RequestItemDetailSubmitStatusSuccess({this.message});

  @override
  List<Object> get props => [];
}