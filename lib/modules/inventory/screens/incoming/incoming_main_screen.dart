import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class IncomingMainScreen extends StatelessWidget {
  static const routeName = '/incoming';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<IncomingBloc>(
      create: (BuildContext context) => IncomingBloc()..add(LoadIncomingStarted()),
      child: TmpIncomingMain()
    );
  }
}