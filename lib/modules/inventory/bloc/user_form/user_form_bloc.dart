import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'user_form_event.dart';
part 'user_form_state.dart';

class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  UserFormBloc() : super(UserFormInitial());

  @override
  Stream<UserFormState> mapEventToState(
    UserFormEvent event,
  ) async* {
    if(event is AddUserButtonPressed) {
      yield* _addUser(event);
    } else if(event is EditUserButtonPressed) {
      yield* _editUser(event);
    }
  }

  Stream<UserFormState> _addUser(AddUserButtonPressed event) async* {
    yield UserFormSubmitInProgress();
    UserRepository _userRepository = UserRepository();
    await _userRepository.createUser(
      name: event.name,
      email: event.email,
      role: event.role,
      password: event.password
    );
    yield UserFormSubmitSuccess(message: 'User Created');
  }

  Stream<UserFormState> _editUser(EditUserButtonPressed event) async* {
    yield UserFormSubmitInProgress();
    UserRepository _userRepository = UserRepository();
    await _userRepository.updateUser(user: event.user);
    yield UserFormSubmitSuccess(message: 'User Updated');
  }
}
