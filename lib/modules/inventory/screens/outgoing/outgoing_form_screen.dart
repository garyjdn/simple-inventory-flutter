import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class OutgoingFormScreenArguments {
  final String title;
  final String action;
  final Outgoing outgoing;

  OutgoingFormScreenArguments({
    @required this.title,
    @required this.action,
    this.outgoing
  });
}

class OutgoingFormScreen extends StatelessWidget {
  static const routeName = '/outgoing/form';

  @override
  Widget build(BuildContext context) {
    OutgoingFormScreenArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<OutgoingFormBloc>(
      create: (BuildContext context) => OutgoingFormBloc()..add(LoadOutgoingFormStarted()),
      child: TmpOutgoingForm(
        title: args.title,
        action: args.action,
        outgoing: args.outgoing,
      ),
    );
  }
}