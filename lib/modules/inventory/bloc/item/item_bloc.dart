import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';

part 'item_event.dart';
part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  ItemBloc() : super(ItemInitial());

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if(event is LoadItemStarted) {
      yield* _loadItemStarted(event);
    } else if(event is DeleteItemButtonPressed) {
      yield* _deleteItem(event);
    }
  }

  Stream<ItemState> _loadItemStarted(LoadItemStarted event) async* {
    yield ItemLoadStarted();
    ItemRepository _itemRepository = ItemRepository();
    List<Item> items = await _itemRepository.getAllData();
    yield ItemLoadSuccess(items: items);
  }

  Stream<ItemState> _deleteItem(DeleteItemButtonPressed event) async* {
    yield ItemLoadStarted();
    ItemRepository _itemRepository = ItemRepository();
    await _itemRepository.deleteItem(event.item);
    yield ItemDeleteSuccess(message: 'Item deleted');
  }
}
