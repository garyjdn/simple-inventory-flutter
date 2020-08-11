part of 'incoming_form_bloc.dart';

abstract class IncomingFormEvent extends Equatable {
  const IncomingFormEvent();
}

class LoadIncomingFormStarted extends IncomingFormEvent {
  @override
  List<Object> get props => [];
  
}

class AddIncomingButtonPressed extends IncomingFormEvent {
  final DateTime date;
  final Supplier supplier;
  final Item item;
  final int amount;

  AddIncomingButtonPressed({
    @required this.date,
    @required this.supplier,
    @required this.item,
    @required this.amount,
  }):
    assert(supplier != null),
    assert(item != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditIncomingButtonPressed extends IncomingFormEvent {
  final Incoming incoming;
  final int oldAmount;

  EditIncomingButtonPressed({
    @required this.incoming,
    this.oldAmount,
  }):
    assert(incoming != null);

  @override
  List<Object> get props => throw UnimplementedError();
}
