import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:connectivity/connectivity.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is LoginButtonPressed) {
      yield*_loginButtonPressed(event);
    }
  }

  Stream<LoginState> _loginButtonPressed(LoginButtonPressed event) async* {
    yield LoginLoading();
    AuthRepository _authRepository = AuthRepository();
    if(event.email == "") {
      yield LoginFailure(errorMsg: 'Please fill the username field');
    } else if(event.password.length < 6) {
      yield LoginFailure(errorMsg: 'Password length must be at least 6 characters');
    } else {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        yield LoginFailure(errorMsg: 'No internet, please check your phone connection.');
      } else {
        try {
          // check if network have internet access by ping google
          final result = await InternetAddress.lookup('google.com');
          if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
            var response;
            try {
              response = await _authRepository.login(
                email: event.email,
                password: event.password,
              );

              if (response is User) {
                  yield LoginSuccess(
                    user: response
                  );
              } else {
                yield LoginFailure(errorMsg: response['data']);
              }
              
            } catch (error) {
              yield LoginFailure(errorMsg: error.toString());
            }
          }
        } on SocketException catch (_) {
          yield LoginFailure(errorMsg: 'No internet, please check your phone connection.');
        }
      }
    }
  }
}
