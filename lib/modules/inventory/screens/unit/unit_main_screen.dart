import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class UnitMainScreen extends StatelessWidget {
  static const routeName = '/unit';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UnitBloc>(
      create: (BuildContext context) => UnitBloc()..add(LoadUnitStarted()),
      child: TmpUnitMain()
    );
  }
}