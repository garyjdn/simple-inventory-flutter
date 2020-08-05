import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if(event is LoadProfileStarted) {
      yield* _loadProfileStarted(event);
    } else if(event is EditProfileButtonPressed) {
      yield* _editProfile(event);
    }
  }

  Stream<ProfileState> _loadProfileStarted(LoadProfileStarted event) async* {
    yield ProfileLoadStarted();
    UserRepository _userRepository = UserRepository();
    User user = await _userRepository.getUser(uid: event.uid);
    yield ProfileLoadSuccess(user: user);
  }

  Stream<ProfileState> _editProfile(EditProfileButtonPressed event) async* {
    yield ProfileFormSubmitInProgress();

    User user = event.user;

    if(event.image != null) {
      FirebaseStorage fs = FirebaseStorage.instance;
      StorageReference rootReference = fs.ref();
      String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
      StorageReference pictureFolderRef = rootReference.child(imageFileName);

      String imageLink = await pictureFolderRef.putFile(event.image).onComplete.then((storageTask)async{
        String link = await storageTask.ref.getDownloadURL();
        return link;
      });

      user.image = imageLink;
    }

    UserRepository _userRepository = UserRepository();
    await _userRepository.updateUser(user: event.user);
    yield ProfileFormSubmitSuccess(message: 'Profile Updated');
  }
}
