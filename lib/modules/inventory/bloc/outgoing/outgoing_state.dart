part of 'outgoing_bloc.dart';

abstract class OutgoingState extends Equatable {
  const OutgoingState();
}

class OutgoingInitial extends OutgoingState {
  @override
  List<Object> get props => [];
}
