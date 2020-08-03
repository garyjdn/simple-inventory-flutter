part of 'category_form_bloc.dart';

abstract class CategoryFormEvent extends Equatable {
  const CategoryFormEvent();
}

class AddCategoryButtonPressed extends CategoryFormEvent {
  final String name;

  AddCategoryButtonPressed({
    @required this.name,
  }):
    assert(name != null && name.isNotEmpty);

  @override
  List<Object> get props => throw UnimplementedError();
}

class EditCategoryButtonPressed extends CategoryFormEvent {
  final Category category;

  EditCategoryButtonPressed({
    @required this.category,
  }):
    assert(category != null);

  @override
  List<Object> get props => throw UnimplementedError();
}
