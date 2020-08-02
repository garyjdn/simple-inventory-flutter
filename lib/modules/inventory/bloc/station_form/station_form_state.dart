part of 'station_form_bloc.dart';

abstract class StationFormState extends Equatable {
  const StationFormState();
}

class StationFormInitial extends StationFormState {
  @override
  List<Object> get props => [];
}

class StationFormSubmitInProgress extends StationFormState {
  @override
  List<Object> get props => [];
}

class StationFormSubmitSuccess extends StationFormState {
  final String message;

  StationFormSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}