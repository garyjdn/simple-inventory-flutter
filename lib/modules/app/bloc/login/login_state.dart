part of 'login_bloc.dart';

@immutable
abstract class LoginState {}


class LoginInitial extends LoginState with EquatableMixin {
  @override
  List<Object> get props => null;

}

class LoginSuccess extends LoginState with EquatableMixin {
  final User user;

  LoginSuccess({
    @required this.user
  }):
    assert(user != null);
    
  @override
  List<Object> get props => [];
}

class LoginLoading extends LoginState with EquatableMixin {
  @override
  List<Object> get props => [];
}

class LoginFailure extends LoginState {
  final String errorMsg;

  LoginFailure({this.errorMsg});

  @override
  List<Object> get props => [];
}
