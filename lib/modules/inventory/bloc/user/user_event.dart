part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();
}

class LoadUserStarted extends UserEvent {
  @override
  List<Object> get props => [];
  
}

class DeleteUserButtonPressed extends UserEvent {
  final User user;

  DeleteUserButtonPressed({this.user}): assert(user != null);

  @override
  List<Object> get props => throw UnimplementedError();
}