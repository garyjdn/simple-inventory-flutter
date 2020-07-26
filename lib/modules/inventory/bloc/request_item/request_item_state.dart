part of 'request_item_bloc.dart';

abstract class RequestItemState extends Equatable {
  const RequestItemState();
}

class RequestItemInitial extends RequestItemState {
  @override
  List<Object> get props => [];
}
