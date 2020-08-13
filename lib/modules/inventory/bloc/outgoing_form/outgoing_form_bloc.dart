import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'outgoing_form_event.dart';
part 'outgoing_form_state.dart';

class OutgoingFormBloc extends Bloc<OutgoingFormEvent, OutgoingFormState> {
  OutgoingFormBloc() : super(OutgoingFormInitial());

  @override
  Stream<OutgoingFormState> mapEventToState(
    OutgoingFormEvent event,
  ) async* {
    if(event is LoadOutgoingFormStarted) {
      yield* _loadOutgoingFormStarted(event);
    } else if(event is AddOutgoingButtonPressed) {
      yield* _addOutgoing(event);
    } else if(event is EditOutgoingButtonPressed) {
      yield* _editOutgoing(event);
    }
  }

  Stream<OutgoingFormState> _loadOutgoingFormStarted(LoadOutgoingFormStarted event) async* {
    yield OutgoingFormLoadInProgress();

    UserRepository _userRepository = UserRepository();
    List<User> users = await _userRepository.getAllData();

    ItemRepository _itemRepository = ItemRepository();
    List<Item> items = await _itemRepository.getAllData();

    StationRepository _stationRepository = StationRepository();
    List<Station> stations = await _stationRepository.getAllData();
    
    yield OutgoingFormLoadSuccess(
      users: users,
      stations: stations,
      items: items
    );
  }

  Stream<OutgoingFormState> _addOutgoing(AddOutgoingButtonPressed event) async* {
    yield OutgoingFormSubmitInProgress();
    OutgoingRepository _outgoingRepository = OutgoingRepository();
    await _outgoingRepository.createOutgoing(
      date: event.date,
      user: event.user,
      item: event.item,
      station: event.station,
      amount: event.amount
    );

    ItemRepository _itemRepository = ItemRepository();
    Item item = event.item;
    item.stock -= event.amount;
    _itemRepository.updateItem(item: item);

    yield OutgoingFormSubmitSuccess(message: 'Outgoing Created');
  }

  Stream<OutgoingFormState> _editOutgoing(EditOutgoingButtonPressed event) async* {
    yield OutgoingFormSubmitInProgress();
    OutgoingRepository _outgoingRepository = OutgoingRepository();
    await _outgoingRepository.updateOutgoing(outgoing: event.outgoing);

    ItemRepository _itemRepository = ItemRepository();
    Item item = event.outgoing.item;
    item.stock -= (event.outgoing.amount - event.oldAmount);
    await _itemRepository.updateItem(item: item);

    yield OutgoingFormSubmitSuccess(message: 'Outgoing Updated');
  }
}
