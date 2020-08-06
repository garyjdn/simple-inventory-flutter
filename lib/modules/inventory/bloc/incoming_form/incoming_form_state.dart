part of 'incoming_form_bloc.dart';

abstract class IncomingFormState extends Equatable {
  const IncomingFormState();
}

class IncomingFormInitial extends IncomingFormState {
  @override
  List<Object> get props => [];
}

class IncomingFormLoadInProgress extends IncomingFormState {
  @override
  List<Object> get props => [];

}

class IncomingFormLoadSuccess extends IncomingFormState {
  final List<Supplier> suppliers;
  final List<Item> items;

  IncomingFormLoadSuccess({
    @required this.suppliers,
    @required this.items
  });

  @override
  List<Object> get props => [];
}

class IncomingFormSubmitInProgress extends IncomingFormState {
  @override
  List<Object> get props => [];
}

class IncomingFormSubmitSuccess extends IncomingFormState {
  final String message;

  IncomingFormSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}