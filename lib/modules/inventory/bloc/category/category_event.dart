part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class LoadCategoryStarted extends CategoryEvent {
  @override
  List<Object> get props => [];
  
}

class DeleteCategoryButtonPressed extends CategoryEvent {
  final Category category;

  DeleteCategoryButtonPressed({this.category}): assert(category != null);

  @override
  List<Object> get props => throw UnimplementedError();
}