part of 'user_form_bloc.dart';

abstract class UserFormEvent extends Equatable {
  const UserFormEvent();
}

class AddUserButtonPressed extends UserFormEvent {
  final String name;
  final String email;
  final String role;
  final String password;

  AddUserButtonPressed({
    @required this.name,
    @required this.email,
    @required this.role,
    @required this.password
  }):
    assert(name != null && name.isNotEmpty),
    assert(email != null && email.isNotEmpty),
    assert(role != null && role.isNotEmpty);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditUserButtonPressed extends UserFormEvent {
  final User user;

  EditUserButtonPressed({
    @required this.user,
  }):
    assert(user != null);

  @override
  List<Object> get props => throw UnimplementedError();
}
