import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class ItemFormScreenArguments {
  final String title;
  final String action;
  final Item item;

  ItemFormScreenArguments({
    @required this.title,
    @required this.action,
    this.item
  });
}

class ItemFormScreen extends StatelessWidget {
  static const routeName = '/item/form';

  @override
  Widget build(BuildContext context) {
    ItemFormScreenArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<ItemFormBloc>(
      create: (BuildContext context) => ItemFormBloc()..add(LoadItemFormStarted()),
      child: TmpItemForm(
        title: args.title,
        action: args.action,
        item: args.item,
      ),
    );
  }
}