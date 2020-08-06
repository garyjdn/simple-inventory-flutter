part of 'outgoing_bloc.dart';

abstract class OutgoingEvent extends Equatable {
  const OutgoingEvent();
}

class LoadOutgoingStarted extends OutgoingEvent {
  @override
  List<Object> get props => [];
  
}

class DeleteOutgoingButtonPressed extends OutgoingEvent {
  final Outgoing outgoing;

  DeleteOutgoingButtonPressed({this.outgoing}): assert(outgoing != null);

  @override
  List<Object> get props => throw UnimplementedError();
}