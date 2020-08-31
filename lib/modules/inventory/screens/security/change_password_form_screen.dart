import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/inventory/bloc/change_password/change_password_bloc.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class ChangePasswordFormScreen extends StatelessWidget {
  static const routeName = '/security/change-password';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChangePasswordBloc>(
      create: (BuildContext context) => ChangePasswordBloc(),
      child: TmpChangePassword(),
    );
  }
}