import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'station_event.dart';
part 'station_state.dart';

class StationBloc extends Bloc<StationEvent, StationState> {
  StationBloc() : super(StationInitial());

  @override
  Stream<StationState> mapEventToState(
    StationEvent event,
  ) async* {
    if(event is LoadStationStarted) {
      yield* _loadStationStarted(event);
    } else if(event is DeleteStationButtonPressed) {
      yield* _deleteStation(event);
    }
  }

  Stream<StationState> _loadStationStarted(LoadStationStarted event) async* {
    yield StationLoadStarted();
    StationRepository _stationRepository = StationRepository();
    List<Station> stations = await _stationRepository.getAllData();
    yield StationLoadSuccess(stations: stations);
  }

  Stream<StationState> _deleteStation(DeleteStationButtonPressed event) async* {
    yield StationLoadStarted();
    StationRepository _stationRepository = StationRepository();
    await _stationRepository.deleteStation(event.station);
    yield StationDeleteSuccess(message: 'Station deleted');
  }
}
