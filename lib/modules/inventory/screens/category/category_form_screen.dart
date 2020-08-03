import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class CategoryFormScreenArguments {
  final String title;
  final String action;
  final Category category;

  CategoryFormScreenArguments({
    @required this.title,
    @required this.action,
    this.category
  });
}

class CategoryFormScreen extends StatelessWidget {
  static const routeName = '/category/form';

  @override
  Widget build(BuildContext context) {
    CategoryFormScreenArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<CategoryFormBloc>(
      create: (BuildContext context) => CategoryFormBloc(),
      child: TmpCategoryForm(
        title: args.title,
        action: args.action,
        category: args.category,
      ),
    );
  }
}