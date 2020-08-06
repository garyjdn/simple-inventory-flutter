part of 'outgoing_bloc.dart';

abstract class OutgoingState extends Equatable {
  const OutgoingState();
}

class OutgoingInitial extends OutgoingState {
  @override
  List<Object> get props => [];
}

class OutgoingLoadStarted extends OutgoingState {
  @override
  List<Object> get props => [];

}

class OutgoingLoadSuccess extends OutgoingState {
  final List<Outgoing> outgoings;

  OutgoingLoadSuccess({
    @required this.outgoings
  }):
    assert(outgoings != null);

  @override
  List<Object> get props => [];
}

class OutgoingLoadFailure extends OutgoingState {
  final String title;
  final String message;

  OutgoingLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class OutgoingDeleteSuccess extends OutgoingState {
  final String message;

  OutgoingDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}