import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'station_form_event.dart';
part 'station_form_state.dart';

class StationFormBloc extends Bloc<StationFormEvent, StationFormState> {
  StationFormBloc() : super(StationFormInitial());

  @override
  Stream<StationFormState> mapEventToState(
    StationFormEvent event,
  ) async* {
    if(event is AddStationButtonPressed) {
      yield* _addStation(event);
    } else if(event is EditStationButtonPressed) {
      yield* _editStation(event);
    }
  }

  Stream<StationFormState> _addStation(AddStationButtonPressed event) async* {
    yield StationFormSubmitInProgress();
    StationRepository _stationRepository = StationRepository();
    await _stationRepository.createStation(
      name: event.name,
    );
    yield StationFormSubmitSuccess(message: 'Station Created');
  }

  Stream<StationFormState> _editStation(EditStationButtonPressed event) async* {
    yield StationFormSubmitInProgress();
    StationRepository _stationRepository = StationRepository();
    await _stationRepository.updateStation(station: event.station);
    yield StationFormSubmitSuccess(message: 'Station Updated');
  }
}
