part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;
  final bool rememberMe;

  LoginButtonPressed({
    @required this.email,
    @required this.password,
    @required this.rememberMe
  }):
    assert(email != null),
    assert(password != null),
    assert(rememberMe != null);


}