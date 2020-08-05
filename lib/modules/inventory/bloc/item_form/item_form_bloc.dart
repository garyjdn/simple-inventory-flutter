import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';

part 'item_form_event.dart';
part 'item_form_state.dart';

class ItemFormBloc extends Bloc<ItemFormEvent, ItemFormState> {
  ItemFormBloc() : super(ItemFormInitial());

  @override
  Stream<ItemFormState> mapEventToState(
    ItemFormEvent event,
  ) async* {
    if(event is LoadItemFormStarted) {
      yield* _loadItemFormStarted(event);
    } else if(event is AddItemButtonPressed) {
      yield* _addItem(event);
    } else if(event is EditItemButtonPressed) {
      yield* _editItem(event);
    }
  }

  Stream<ItemFormState> _loadItemFormStarted(LoadItemFormStarted event) async* {
    yield ItemFormLoadInProgress();

    CategoryRepository _supplierRepository = CategoryRepository();
    List<Category> categories = await _supplierRepository.getAllData();

    UnitRepository _unitRepository = UnitRepository();
    List<Unit> units = await _unitRepository.getAllData();
    
    yield ItemFormLoadSuccess(
      categories: categories,
      units: units
    );
  }

  Stream<ItemFormState> _addItem(AddItemButtonPressed event) async* {
    yield ItemFormSubmitInProgress();
    ItemRepository _itemRepository = ItemRepository();
    await _itemRepository.createItem(
      name: event.name,
      category: event.category,
      unit: event.unit
    );
    yield ItemFormSubmitSuccess(message: 'Item Created');
  }

  Stream<ItemFormState> _editItem(EditItemButtonPressed event) async* {
    yield ItemFormSubmitInProgress();
    ItemRepository _itemRepository = ItemRepository();
    await _itemRepository.updateItem(item: event.item);
    yield ItemFormSubmitSuccess(message: 'Item Updated');
  }
}
