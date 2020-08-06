import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class OutgoingMainScreen extends StatelessWidget {
  static const routeName = '/outgoing';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<OutgoingBloc>(
      create: (BuildContext context) => OutgoingBloc()..add(LoadOutgoingStarted()),
      child: TmpOutgoingMain()
    );
  }
}