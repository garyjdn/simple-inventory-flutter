part of 'request_item_bloc.dart';

abstract class RequestItemEvent extends Equatable {
  const RequestItemEvent();
}

class LoadRequestItemStarted extends RequestItemEvent {
  final User user;

  LoadRequestItemStarted({@required this. user})
    : assert(user != null);

  @override
  List<Object> get props => [];
  
}

class DeleteRequestItemButtonPressed extends RequestItemEvent {
  final RequestItem requestItem;

  DeleteRequestItemButtonPressed({this.requestItem}): assert(requestItem != null);

  @override
  List<Object> get props => throw UnimplementedError();
}
class AddRequestItemButtonPressed extends RequestItemEvent {
  final User user;
  final Station station;

  AddRequestItemButtonPressed({
    @required this.user,
    @required this.station,
  }):
    assert(user != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

// class EditRequestItemButtonPressed extends RequestItemEvent {
//   final RequestItem requestItem;

//   EditRequestItemButtonPressed({
//     @required this.requestItem,
//   }):
//     assert(requestItem != null);

//   @override
//   List<Object> get props => throw UnimplementedError();
// }
