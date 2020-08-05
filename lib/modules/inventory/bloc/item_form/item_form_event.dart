part of 'item_form_bloc.dart';

abstract class ItemFormEvent extends Equatable {
  const ItemFormEvent();
}

class LoadItemFormStarted extends ItemFormEvent {
  @override
  List<Object> get props => [];
  
}

class AddItemButtonPressed extends ItemFormEvent {
  final String name;
  final Category category;
  final Unit unit;

  AddItemButtonPressed({
    @required this.name,
    @required this.category,
    @required this.unit,
  }):
    assert(name != null && name.isNotEmpty),
    assert(category != null),
    assert(unit != null);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditItemButtonPressed extends ItemFormEvent {
  final Item item;

  EditItemButtonPressed({
    @required this.item,
  }):
    assert(item != null);

  @override
  List<Object> get props => throw UnimplementedError();
}
