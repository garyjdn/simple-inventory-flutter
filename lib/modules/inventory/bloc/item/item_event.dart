part of 'item_bloc.dart';

abstract class ItemEvent extends Equatable {
  const ItemEvent();
}

class LoadItemStarted extends ItemEvent {
  @override
  List<Object> get props => [];
  
}

class DeleteItemButtonPressed extends ItemEvent {
  final Item item;

  DeleteItemButtonPressed({this.item}): assert(item != null);

  @override
  List<Object> get props => throw UnimplementedError();
}