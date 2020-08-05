part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileLoadStarted extends ProfileState {
  @override
  List<Object> get props => [];

}

class ProfileLoadSuccess extends ProfileState {
  final User user;

  ProfileLoadSuccess({
    @required this.user
  }):
    assert(user != null);

  @override
  List<Object> get props => [];
}

class ProfileFormSubmitInProgress extends ProfileState {
  @override
  List<Object> get props => [];
}

class ProfileFormSubmitSuccess extends ProfileState {
  final String message;

  ProfileFormSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}