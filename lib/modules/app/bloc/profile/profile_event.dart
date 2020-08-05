part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class LoadProfileStarted extends ProfileEvent {
  final String uid;

  LoadProfileStarted({this.uid}): 
    assert(uid != null && uid.isNotEmpty);

  @override
  List<Object> get props => [];
  
}

class EditProfileButtonPressed extends ProfileEvent {
  final User user;
  final File image;

  EditProfileButtonPressed({
    @required this.user,
    this.image,
  }):
    assert(user != null);

  @override
  List<Object> get props => throw UnimplementedError();
}