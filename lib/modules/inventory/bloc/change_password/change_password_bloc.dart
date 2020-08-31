import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc() : super(ChangePasswordInitial());

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if(event is ChangePasswordButtonPressed) {
      yield* _changePassword(event);
    }
  }

  Stream<ChangePasswordState> _changePassword(ChangePasswordButtonPressed event) async* {
    yield ChangePasswordInProgress();
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    yield* await user.updatePassword(event.password).then((_) async* {
      print("Succesfull changed password");
      yield ChangePasswordSuccess(message: 'Your password has been changed, please relog to continue');
    }).catchError((error) async* {
      print("Password can't be changed" + error.toString());
      yield ChangePasswordFailed(message: "Password can't be changed" + error.toString());
    });
  }
}
