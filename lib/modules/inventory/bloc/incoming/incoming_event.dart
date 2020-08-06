part of 'incoming_bloc.dart';

abstract class IncomingEvent extends Equatable {
  const IncomingEvent();
}

class LoadIncomingStarted extends IncomingEvent {
  @override
  List<Object> get props => [];
  
}

class DeleteIncomingButtonPressed extends IncomingEvent {
  final Incoming incoming;

  DeleteIncomingButtonPressed({this.incoming}): assert(incoming != null);

  @override
  List<Object> get props => throw UnimplementedError();
}