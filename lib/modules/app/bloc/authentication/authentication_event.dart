part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationEvent extends Equatable {}

class AuthStarted extends AuthenticationEvent {
  @override
  List<Object> get props => null;
}

class LoggedIn extends AuthenticationEvent {
  // final String token;
  final User user;
  final bool rememberMe;

  LoggedIn({
    // @required this.token,
    @required this.user,
    @required this.rememberMe
  })  : 
  // assert(token != null && token.isNotEmpty),
        assert(user != null);

  @override
  List<Object> get props => [
    // token, 
    user
  ];
}

class LoggedOut extends AuthenticationEvent {
  @override
  List<Object> get props => null;
}
