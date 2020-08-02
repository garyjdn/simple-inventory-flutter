import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class UserMainScreen extends StatelessWidget {
  static const routeName = '/user';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (BuildContext context) => UserBloc()..add(LoadUserStarted()),
      child: TmpUserMain()
    );
  }
}