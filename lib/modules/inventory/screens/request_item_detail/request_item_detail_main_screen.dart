import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class RequestItemDetailMainScreen extends StatelessWidget {
  static const routeName = '/request-item-detail';

  @override
  Widget build(BuildContext context) {
    RequestItem args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<RequestItemDetailBloc>(
      create: (BuildContext context) => RequestItemDetailBloc()..add(LoadRequestItemDetailStarted(requestItem: args)),
      child: TmpRequestItemDetailMain(
        requestItem: args
      )
    );
  }
}