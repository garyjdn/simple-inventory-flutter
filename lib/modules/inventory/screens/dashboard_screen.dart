import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if(state is AuthenticationSuccess) {
          return BlocProvider(
            create: (BuildContext context) {
              return DashboardBloc()
                ..add(DashboardStarted());
            },
            child: TmpDashboard()
          );
        }
      }
    );
  }
}