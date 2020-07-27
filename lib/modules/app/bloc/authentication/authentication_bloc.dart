import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:inventoryapp/data/data.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if(event is AuthStarted) {
      yield* _authStarted(event);
    } else if(event is LoggedIn) {
      yield* _loggedIn(event);
    } else if(event is LoggedOut) {
      yield* _loggedOut(event);
    }
  }

  Future<dynamic> _getAuthData() async {
    AuthRepository _authRepository = AuthRepository();
    if(await _authRepository.hasToken()) {
      return await _authRepository.getAuthenticatedData();
    }
    return null;
  }

  Stream<AuthenticationState> _authStarted(AuthStarted event) async* {
    var authData = await _getAuthData(); 
    if(authData != null) {
      yield AuthenticationSuccess(
        user: authData['user']
      );
    } else {
      yield AuthenticationFailure();
    }
  }

  Stream<AuthenticationState> _loggedIn(LoggedIn event) async* {
    AuthRepository _authRepository = AuthRepository();
      if(event.rememberMe) {
      Map<String, dynamic> cache = {
        'user': event.user.toMap(),
      };
      _authRepository.persistToken(cache);
    }
    yield AuthenticationSuccess(
      user: event.user
    );
  }

  Stream<AuthenticationState> _loggedOut(LoggedOut event) async* {
    AuthRepository _authRepository = AuthRepository();
    _authRepository.logout();
    yield AuthenticationFailure();
  }
}
