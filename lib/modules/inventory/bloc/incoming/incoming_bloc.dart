import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'incoming_event.dart';
part 'incoming_state.dart';

class IncomingBloc extends Bloc<IncomingEvent, IncomingState> {
  IncomingBloc() : super(IncomingInitial());

  @override
  Stream<IncomingState> mapEventToState(
    IncomingEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
