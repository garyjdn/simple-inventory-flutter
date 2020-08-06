import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class IncomingFormScreenArguments {
  final String title;
  final String action;
  final Incoming incoming;

  IncomingFormScreenArguments({
    @required this.title,
    @required this.action,
    this.incoming
  });
}

class IncomingFormScreen extends StatelessWidget {
  static const routeName = '/incoming/form';

  @override
  Widget build(BuildContext context) {
    IncomingFormScreenArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<IncomingFormBloc>(
      create: (BuildContext context) => IncomingFormBloc()..add(LoadIncomingFormStarted()),
      child: TmpIncomingForm(
        title: args.title,
        action: args.action,
        incoming: args.incoming,
      ),
    );
  }
}