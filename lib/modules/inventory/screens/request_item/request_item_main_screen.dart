import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class RequestItemMainScreen extends StatelessWidget {
  static const routeName = '/request-item';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<RequestItemBloc>(
      create: (BuildContext context) => RequestItemBloc()..add(LoadRequestItemStarted()),
      child: TmpRequestItemMain()
    );
  }
}