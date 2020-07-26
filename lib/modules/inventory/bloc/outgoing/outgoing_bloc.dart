import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'outgoing_event.dart';
part 'outgoing_state.dart';

class OutgoingBloc extends Bloc<OutgoingEvent, OutgoingState> {
  OutgoingBloc() : super(OutgoingInitial());

  @override
  Stream<OutgoingState> mapEventToState(
    OutgoingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
