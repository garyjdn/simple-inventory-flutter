import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(UnitInitial());

  @override
  Stream<UnitState> mapEventToState(
    UnitEvent event,
  ) async* {
    if(event is LoadUnitStarted) {
      yield* _loadUnitStarted(event);
    } else if(event is DeleteUnitButtonPressed) {
      yield* _deleteUnit(event);
    }
  }

  Stream<UnitState> _loadUnitStarted(LoadUnitStarted event) async* {
    yield UnitLoadStarted();
    UnitRepository _unitRepository = UnitRepository();
    List<Unit> units = await _unitRepository.getAllData();
    yield UnitLoadSuccess(units: units);
  }

  Stream<UnitState> _deleteUnit(DeleteUnitButtonPressed event) async* {
    yield UnitLoadStarted();
    UnitRepository _unitRepository = UnitRepository();
    await _unitRepository.deleteUnit(event.unit);
    yield UnitDeleteSuccess(message: 'Unit deleted');
  }
}
