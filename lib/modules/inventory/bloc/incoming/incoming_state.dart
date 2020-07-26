part of 'incoming_bloc.dart';

abstract class IncomingState extends Equatable {
  const IncomingState();
}

class IncomingInitial extends IncomingState {
  @override
  List<Object> get props => [];
}
