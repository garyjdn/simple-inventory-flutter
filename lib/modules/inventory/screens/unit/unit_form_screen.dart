import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class UnitFormScreenArguments {
  final String title;
  final String action;
  final Unit unit;

  UnitFormScreenArguments({
    @required this.title,
    @required this.action,
    this.unit
  });
}

class UnitFormScreen extends StatelessWidget {
  static const routeName = '/unit/form';

  @override
  Widget build(BuildContext context) {
    UnitFormScreenArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<UnitFormBloc>(
      create: (BuildContext context) => UnitFormBloc(),
      child: TmpUnitForm(
        title: args.title,
        action: args.action,
        unit: args.unit,
      ),
    );
  }
}