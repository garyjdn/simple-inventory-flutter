import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'station_event.dart';
part 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  StationBloc() : super(StationInitial());

  @override
  Stream<StationState> mapEventToState(
    StationEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
