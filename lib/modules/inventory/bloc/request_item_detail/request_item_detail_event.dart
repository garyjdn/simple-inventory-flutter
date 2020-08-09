part of 'request_item_detail_bloc.dart';

abstract class RequestItemDetailEvent extends Equatable {
  const RequestItemDetailEvent();
}

class LoadRequestItemDetailStarted extends RequestItemDetailEvent {
  final RequestItem requestItem;

  LoadRequestItemDetailStarted({@required this.requestItem});

  @override
  List<Object> get props => [];
  
}

class DeleteRequestItemDetailButtonPressed extends RequestItemDetailEvent {
  final RequestItemDetail requestItemDetail;

  DeleteRequestItemDetailButtonPressed({this.requestItemDetail}): assert(requestItemDetail != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

class AddRequestItemDetailButtonPressed extends RequestItemDetailEvent {
  final RequestItem requestItem;
  final Item item;
  final int amount;

  AddRequestItemDetailButtonPressed({
    @required this.requestItem,
    @required this.item,
    @required this.amount
  }):
    assert(requestItem != null),
    assert(item != null),
    assert(amount != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditRequestItemDetailButtonPressed extends RequestItemDetailEvent {
  final RequestItemDetail requestItemDetail;

  EditRequestItemDetailButtonPressed({
    @required this.requestItemDetail,
  }):
    assert(requestItemDetail != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditRequestItemButtonPressed extends RequestItemDetailEvent {
  final RequestItem requestItem;

  EditRequestItemButtonPressed({
    @required this.requestItem,
  }):
    assert(requestItem != null);

  @override
  List<Object> get props => throw UnimplementedError();
}