part of 'outgoing_form_bloc.dart';

abstract class OutgoingFormEvent extends Equatable {
  const OutgoingFormEvent();
}

class LoadOutgoingFormStarted extends OutgoingFormEvent {
  @override
  List<Object> get props => [];
  
}

class AddOutgoingButtonPressed extends OutgoingFormEvent {
  final DateTime date;
  final User user;
  final Item item;
  final Station station;
  final int amount;

  AddOutgoingButtonPressed({
    @required this.date,
    @required this.user,
    @required this.item,
    @required this.station,
    @required this.amount,
  }):
    assert(user != null),
    assert(station != null),
    assert(item != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditOutgoingButtonPressed extends OutgoingFormEvent {
  final Outgoing outgoing;

  EditOutgoingButtonPressed({
    @required this.outgoing,
  }):
    assert(outgoing != null);

  @override
  List<Object> get props => throw UnimplementedError();
}