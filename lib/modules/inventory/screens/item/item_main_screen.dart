import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class ItemMainScreen extends StatelessWidget {
  static const routeName = '/item';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemBloc>(
      create: (BuildContext context) => ItemBloc()..add(LoadItemStarted()),
      child: TmpItemMain()
    );
  }
}