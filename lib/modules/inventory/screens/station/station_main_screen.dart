import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class StationMainScreen extends StatelessWidget {
  static const routeName = '/station';
  @override
  Widget build(BuildContext context) {
    return BlocProvider<StationBloc>(
      create: (BuildContext context) => StationBloc()..add(LoadStationStarted()),
      child: TmpStationMain()
    );
  }
}