import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';

part 'category_form_event.dart';
part 'category_form_state.dart';

class CategoryFormBloc extends Bloc<CategoryFormEvent, CategoryFormState> {
  CategoryFormBloc() : super(CategoryFormInitial());

  @override
  Stream<CategoryFormState> mapEventToState(
    CategoryFormEvent event,
  ) async* {
    if(event is AddCategoryButtonPressed) {
      yield* _addCategory(event);
    } else if(event is EditCategoryButtonPressed) {
      yield* _editCategory(event);
    }
  }

  Stream<CategoryFormState> _addCategory(AddCategoryButtonPressed event) async* {
    yield CategoryFormSubmitInProgress();
    CategoryRepository _categoryRepository = CategoryRepository();
    await _categoryRepository.createCategory(
      name: event.name,
    );
    yield CategoryFormSubmitSuccess(message: 'Category Created');
  }

  Stream<CategoryFormState> _editCategory(EditCategoryButtonPressed event) async* {
    yield CategoryFormSubmitInProgress();
    CategoryRepository _categoryRepository = CategoryRepository();
    await _categoryRepository.updateCategory(category: event.category);
    yield CategoryFormSubmitSuccess(message: 'Category Updated');
  }
}
