import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:package_info/package_info.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if(event is AppStarted) {
      // yield AppLoading();
      PackageInfo pkgInfo = await PackageInfo.fromPlatform();
      String buildNumber = pkgInfo.buildNumber;
      String version = '${pkgInfo.version} ($buildNumber)';
      await Future.delayed(Duration(seconds: 3), () {});
      yield AppInformationLoaded(version: version);
    }
  }
}
