part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadStarted extends CategoryState {
  @override
  List<Object> get props => [];

}

class CategoryLoadSuccess extends CategoryState {
  final List<Category> categories;

  CategoryLoadSuccess({
    @required this.categories
  }):
    assert(categories != null);

  @override
  List<Object> get props => [];
}

class CategoryLoadFailure extends CategoryState {
  final String title;
  final String message;

  CategoryLoadFailure({
    this.title,
    @required this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  List<Object> get props => [];
}

class CategoryDeleteSuccess extends CategoryState {
  final String message;

  CategoryDeleteSuccess({
    this.message
  });

  @override
  List<Object> get props => [];
}