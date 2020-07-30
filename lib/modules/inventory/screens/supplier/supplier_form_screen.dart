import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class SupplierFormScreenArguments {
  final String title;
  final String action;
  final Supplier supplier;

  SupplierFormScreenArguments({
    @required this.title,
    @required this.action,
    this.supplier
  });
}

class SupplierFormScreen extends StatelessWidget {
  static const routeName = '/supplier/form';

  @override
  Widget build(BuildContext context) {
    SupplierFormScreenArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<SupplierFormBloc>(
      create: (BuildContext context) => SupplierFormBloc(),
      child: TmpSupplierForm(
        title: args.title,
        action: args.action,
        supplier: args.supplier,
      ),
    );
  }
}