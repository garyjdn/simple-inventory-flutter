part of 'unit_form_bloc.dart';

abstract class UnitFormState extends Equatable {
  const UnitFormState();
}

class UnitFormInitial extends UnitFormState {
  @override
  List<Object> get props => [];
}

class UnitFormSubmitInProgress extends UnitFormState {
  @override
  List<Object> get props => [];
}

class UnitFormSubmitSuccess extends UnitFormState {
  final String message;

  UnitFormSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}