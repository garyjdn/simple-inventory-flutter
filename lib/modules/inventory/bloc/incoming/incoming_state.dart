part of 'incoming_bloc.dart';

abstract class IncomingState extends Equatable {
  const IncomingState();
}

class IncomingInitial extends IncomingState {
  @override
  List<Object> get props => [];
}

class IncomingLoadStarted extends IncomingState {
  @override
  List<Object> get props => [];

}

class IncomingLoadSuccess extends IncomingState {
  final List<Incoming> incomings;

  IncomingLoadSuccess({
    @required this.incomings
  }):
    assert(incomings != null);

  @override
  List<Object> get props => [];
}

class IncomingLoadFailure extends IncomingState {
  final String title;
  final String message;

  IncomingLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class IncomingDeleteSuccess extends IncomingState {
  final String message;

  IncomingDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}