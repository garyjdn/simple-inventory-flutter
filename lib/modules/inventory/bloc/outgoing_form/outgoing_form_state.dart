part of 'outgoing_form_bloc.dart';

abstract class OutgoingFormState extends Equatable {
  const OutgoingFormState();
}

class OutgoingFormInitial extends OutgoingFormState {
  @override
  List<Object> get props => [];
}

class OutgoingFormLoadInProgress extends OutgoingFormState {
  @override
  List<Object> get props => [];

}

class OutgoingFormLoadSuccess extends OutgoingFormState {
  final List<User> users;
  final List<Station> stations;
  final List<Item> items;

  OutgoingFormLoadSuccess({
    @required this.users,
    @required this.stations,
    @required this.items
  });

  @override
  List<Object> get props => [];
}

class OutgoingFormSubmitInProgress extends OutgoingFormState {
  @override
  List<Object> get props => [];
}

class OutgoingFormSubmitSuccess extends OutgoingFormState {
  final String message;

  OutgoingFormSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}