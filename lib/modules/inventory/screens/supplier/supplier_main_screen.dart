import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class SupplierMainScreen extends StatelessWidget {
  static const routeName = '/supplier';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SupplierBloc>(
      create: (BuildContext context) => SupplierBloc()..add(LoadSupplierStarted()),
      child: TmpSupplierMain()
    );
  }
}