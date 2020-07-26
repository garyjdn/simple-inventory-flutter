import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'unit_event.dart';
part 'unit_state.dart';

class UnitBloc extends Bloc<UnitEvent, UnitState> {
  UnitBloc() : super(UnitInitial());

  @override
  Stream<UnitState> mapEventToState(
    UnitEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
