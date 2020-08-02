import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'unit_form_event.dart';
part 'unit_form_state.dart';

class UnitFormBloc extends Bloc<UnitFormEvent, UnitFormState> {
  UnitFormBloc() : super(UnitFormInitial());

  @override
  Stream<UnitFormState> mapEventToState(
    UnitFormEvent event,
  ) async* {
    if(event is AddUnitButtonPressed) {
      yield* _addUnit(event);
    } else if(event is EditUnitButtonPressed) {
      yield* _editUnit(event);
    }
  }

  Stream<UnitFormState> _addUnit(AddUnitButtonPressed event) async* {
    yield UnitFormSubmitInProgress();
    UnitRepository _unitRepository = UnitRepository();
    await _unitRepository.createUnit(
      name: event.name,
    );
    yield UnitFormSubmitSuccess(message: 'Unit Created');
  }

  Stream<UnitFormState> _editUnit(EditUnitButtonPressed event) async* {
    yield UnitFormSubmitInProgress();
    UnitRepository _unitRepository = UnitRepository();
    await _unitRepository.updateUnit(unit: event.unit);
    yield UnitFormSubmitSuccess(message: 'Unit Updated');
  }
}
