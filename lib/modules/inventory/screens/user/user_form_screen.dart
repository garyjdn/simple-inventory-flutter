import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class UserFormScreenArguments {
  final String title;
  final String action;
  final User user;

  UserFormScreenArguments({
    @required this.title,
    @required this.action,
    this.user
  });
}

class UserFormScreen extends StatelessWidget {
  static const routeName = '/user/form';

  @override
  Widget build(BuildContext context) {
    UserFormScreenArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<UserFormBloc>(
      create: (BuildContext context) => UserFormBloc(),
      child: TmpUserForm(
        title: args.title,
        action: args.action,
        user: args.user,
      ),
    );
  }
}