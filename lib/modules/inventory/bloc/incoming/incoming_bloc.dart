import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'incoming_event.dart';
part 'incoming_state.dart';

class IncomingBloc extends Bloc<IncomingEvent, IncomingState> {
  IncomingBloc() : super(IncomingInitial());

  @override
  Stream<IncomingState> mapEventToState(
    IncomingEvent event,
  ) async* {
    if(event is LoadIncomingStarted) {
      yield* _loadIncomingStarted(event);
    } else if(event is DeleteIncomingButtonPressed) {
      yield* _deleteIncoming(event);
    }
  }

  Stream<IncomingState> _loadIncomingStarted(LoadIncomingStarted event) async* {
    yield IncomingLoadStarted();
    IncomingRepository _incomingRepository = IncomingRepository();
    List<Incoming> incomings = await _incomingRepository.getAllData();
    
    yield IncomingLoadSuccess(incomings: incomings);
  }

  Stream<IncomingState> _deleteIncoming(DeleteIncomingButtonPressed event) async* {
    yield IncomingLoadStarted();
    IncomingRepository _incomingRepository = IncomingRepository();
    await _incomingRepository.deleteIncoming(event.incoming);
    yield IncomingDeleteSuccess(message: 'Incoming deleted');
  }
}
