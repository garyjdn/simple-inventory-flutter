part of 'user_form_bloc.dart';

abstract class UserFormState extends Equatable {
  const UserFormState();
}

class UserFormInitial extends UserFormState {
  @override
  List<Object> get props => [];
}

class UserFormSubmitInProgress extends UserFormState {
  @override
  List<Object> get props => [];
}

class UserFormSubmitSuccess extends UserFormState {
  final String message;

  UserFormSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}