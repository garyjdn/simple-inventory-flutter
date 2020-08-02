part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoadStarted extends UserState {
  @override
  List<Object> get props => [];

}

class UserLoadSuccess extends UserState {
  final List<User> users;

  UserLoadSuccess({
    @required this.users
  }):
    assert(users != null);

  @override
  List<Object> get props => [];
}

class UserLoadFailure extends UserState {
  final String title;
  final String message;

  UserLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class UserDeleteSuccess extends UserState {
  final String message;

  UserDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}