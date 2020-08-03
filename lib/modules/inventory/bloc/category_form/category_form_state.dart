part of 'category_form_bloc.dart';

abstract class CategoryFormState extends Equatable {
  const CategoryFormState();
}

class CategoryFormInitial extends CategoryFormState {
  @override
  List<Object> get props => [];
}

class CategoryFormSubmitInProgress extends CategoryFormState {
  @override
  List<Object> get props => [];
}

class CategoryFormSubmitSuccess extends CategoryFormState {
  final String message;

  CategoryFormSubmitSuccess({this.message});

  @override
  List<Object> get props => [];
}