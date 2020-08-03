import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial());

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    if(event is LoadCategoryStarted) {
      yield* _loadCategoryStarted(event);
    } else if(event is DeleteCategoryButtonPressed) {
      yield* _deleteCategory(event);
    }
  }

  Stream<CategoryState> _loadCategoryStarted(LoadCategoryStarted event) async* {
    yield CategoryLoadStarted();
    CategoryRepository _supplierRepository = CategoryRepository();
    List<Category> categories = await _supplierRepository.getAllData();
    yield CategoryLoadSuccess(categories: categories);
  }

  Stream<CategoryState> _deleteCategory(DeleteCategoryButtonPressed event) async* {
    yield CategoryLoadStarted();
    CategoryRepository _supplierRepository = CategoryRepository();
    await _supplierRepository.deleteCategory(event.category);
    yield CategoryDeleteSuccess(message: 'Category deleted');
  }
}
