part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangePasswordButtonPressed extends ChangePasswordEvent {
  final String password;

  ChangePasswordButtonPressed({@required this.password});

  @override
  List<Object> get props => null;
}