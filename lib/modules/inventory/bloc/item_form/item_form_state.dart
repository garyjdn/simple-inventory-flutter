part of 'item_form_bloc.dart';

abstract class ItemFormState extends Equatable {
  const ItemFormState();
}

class ItemFormInitial extends ItemFormState {
  @override
  List<Object> get props => [];
}

class ItemFormLoadInProgress extends ItemFormState {
  @override
  List<Object> get props => [];

}

class ItemFormLoadSuccess extends ItemFormState {
  final List<Category> categories;
  final List<Unit> units;

  ItemFormLoadSuccess({
    @required this.categories,
    @required this.units
  });

  @override
  List<Object> get props => [];
}

class ItemFormSubmitInProgress extends ItemFormState {
  @override
  List<Object> get props => [];
}

class ItemFormSubmitSuccess extends ItemFormState {
  final String message;

  ItemFormSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}