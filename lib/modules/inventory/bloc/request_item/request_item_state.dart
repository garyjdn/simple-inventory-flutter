part of 'request_item_bloc.dart';

abstract class RequestItemState extends Equatable {
  const RequestItemState();
}

class RequestItemInitial extends RequestItemState {
  @override
  List<Object> get props => [];
}

class RequestItemLoadStarted extends RequestItemState {
  @override
  List<Object> get props => [];

}

class RequestItemLoadSuccess extends RequestItemState {
  final List<RequestItem> requestItems;

  RequestItemLoadSuccess({
    @required this.requestItems
  }):
    assert(requestItems != null);

  @override
  List<Object> get props => [];
}

class RequestItemLoadFailure extends RequestItemState {
  final String title;
  final String message;

  RequestItemLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class RequestItemDeleteSuccess extends RequestItemState {
  final String message;

  RequestItemDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}

class RequestItemSubmitInProgress extends RequestItemState {
  @override
  List<Object> get props => [];
}

class RequestItemSubmitSuccess extends RequestItemState {
  final String message;

  RequestItemSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}