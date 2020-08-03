import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class CategoryMainScreen extends StatelessWidget {
  static const routeName = '/category';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategoryBloc>(
      create: (BuildContext context) => CategoryBloc()..add(LoadCategoryStarted()),
      child: TmpCategoryMain()
    );
  }
}