part of 'item_bloc.dart';

abstract class ItemState extends Equatable {
  const ItemState();
}

class ItemInitial extends ItemState {
  @override
  List<Object> get props => [];
}

class ItemLoadStarted extends ItemState {
  @override
  List<Object> get props => [];

}

class ItemLoadSuccess extends ItemState {
  final List<Item> items;

  ItemLoadSuccess({
    @required this.items
  }):
    assert(items != null);

  @override
  List<Object> get props => [];
}

class ItemLoadFailure extends ItemState {
  final String title;
  final String message;

  ItemLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class ItemDeleteSuccess extends ItemState {
  final String message;

  ItemDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}