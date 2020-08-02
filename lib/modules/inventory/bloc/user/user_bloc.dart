import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if(event is LoadUserStarted) {
      yield* _loadUserStarted(event);
    } else if(event is DeleteUserButtonPressed) {
      yield* _deleteUser(event);
    }
  }

  Stream<UserState> _loadUserStarted(LoadUserStarted event) async* {
    yield UserLoadStarted();
    UserRepository _userRepository = UserRepository();
    List<User> users = await _userRepository.getAllData();
    yield UserLoadSuccess(users: users);
  }

  Stream<UserState> _deleteUser(DeleteUserButtonPressed event) async* {
    yield UserLoadStarted();
    UserRepository _userRepository = UserRepository();
    await _userRepository.deleteUser(event.user);
    yield UserDeleteSuccess(message: 'User deleted');
  }
}
