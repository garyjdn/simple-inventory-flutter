import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class StationFormScreenArguments {
  final String title;
  final String action;
  final Station station;

  StationFormScreenArguments({
    @required this.title,
    @required this.action,
    this.station
  });
}

class StationFormScreen extends StatelessWidget {
  static const routeName = '/station/form';

  @override
  Widget build(BuildContext context) {
    StationFormScreenArguments args = ModalRoute.of(context).settings.arguments;
    return BlocProvider<StationFormBloc>(
      create: (BuildContext context) => StationFormBloc(),
      child: TmpStationForm(
        title: args.title,
        action: args.action,
        station: args.station,
      ),
    );
  }
}