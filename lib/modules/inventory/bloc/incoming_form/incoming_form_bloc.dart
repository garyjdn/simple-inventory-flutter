import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:inventoryapp/data/data.dart';

part 'incoming_form_event.dart';
part 'incoming_form_state.dart';

class IncomingFormBloc extends Bloc<IncomingFormEvent, IncomingFormState> {
  IncomingFormBloc() : super(IncomingFormInitial());

  @override
  Stream<IncomingFormState> mapEventToState(
    IncomingFormEvent event,
  ) async* {
    if(event is LoadIncomingFormStarted) {
      yield* _loadIncomingFormStarted(event);
    } else if(event is AddIncomingButtonPressed) {
      yield* _addIncoming(event);
    } else if(event is EditIncomingButtonPressed) {
      yield* _editIncoming(event);
    }
  }

  Stream<IncomingFormState> _loadIncomingFormStarted(LoadIncomingFormStarted event) async* {
    yield IncomingFormLoadInProgress();

    SupplierRepository _supplierRepository = SupplierRepository();
    List<Supplier> suppliers = await _supplierRepository.getAllData();

    ItemRepository _unitRepository = ItemRepository();
    List<Item> items = await _unitRepository.getAllData();
    
    yield IncomingFormLoadSuccess(
      suppliers: suppliers,
      items: items
    );
  }

  Stream<IncomingFormState> _addIncoming(AddIncomingButtonPressed event) async* {
    yield IncomingFormSubmitInProgress();
    IncomingRepository _incomingRepository = IncomingRepository();
    await _incomingRepository.createIncoming(
      date: event.date,
      supplier: event.supplier,
      item: event.item,
      amount: event.amount
    );

    ItemRepository _itemRepository = ItemRepository();
    Item item = event.item;
    item.stock += event.amount;
    _itemRepository.updateItem(item: item);

    yield IncomingFormSubmitSuccess(message: 'Incoming Created');
  }

  Stream<IncomingFormState> _editIncoming(EditIncomingButtonPressed event) async* {
    yield IncomingFormSubmitInProgress();
    IncomingRepository _incomingRepository = IncomingRepository();
    await _incomingRepository.updateIncoming(incoming: event.incoming);

    ItemRepository _itemRepository = ItemRepository();
    // Item item = await _itemRepository.getItem(uid: event.incoming.item.id);
    Item item = event.incoming.item;
    item.stock += (event.incoming.amount - event.oldAmount);
    await _itemRepository.updateItem(item: item);

    yield IncomingFormSubmitSuccess(message: 'Incoming Updated');
  }
}
