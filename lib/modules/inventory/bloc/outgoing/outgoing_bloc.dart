import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'outgoing_event.dart';
part 'outgoing_state.dart';

class OutgoingBloc extends Bloc<OutgoingEvent, OutgoingState> {
  OutgoingBloc() : super(OutgoingInitial());

  @override
  Stream<OutgoingState> mapEventToState(
    OutgoingEvent event,
  ) async* {
    if(event is LoadOutgoingStarted) {
      yield* _loadOutgoingStarted(event);
    } else if(event is DeleteOutgoingButtonPressed) {
      yield* _deleteOutgoing(event);
    }
  }

  Stream<OutgoingState> _loadOutgoingStarted(LoadOutgoingStarted event) async* {
    yield OutgoingLoadStarted();
    OutgoingRepository _outgoingRepository = OutgoingRepository();
    List<Outgoing> outgoings = await _outgoingRepository.getAllData();
    
    yield OutgoingLoadSuccess(outgoings: outgoings);
  }

  Stream<OutgoingState> _deleteOutgoing(DeleteOutgoingButtonPressed event) async* {
    yield OutgoingLoadStarted();
    OutgoingRepository _outgoingRepository = OutgoingRepository();
    await _outgoingRepository.deleteOutgoing(event.outgoing);

    ItemRepository _itemRepository = ItemRepository();
    Item item = event.outgoing.item;
    item.stock += event.outgoing.amount;
    await _itemRepository.updateItem(item: item);

    yield OutgoingDeleteSuccess(message: 'Outgoing deleted');
  }
}
