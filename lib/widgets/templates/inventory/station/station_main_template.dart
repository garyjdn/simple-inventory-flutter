import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;

class TmpStationMain extends StatelessWidget {
  StationBloc _stationBloc;

  Future deleteDialog(BuildContext ctx, Station station) async {
    return await showDialog(
      context: ctx,
      builder: (BuildContext context) => CustomDialog(
        title: 'Delete Station?',
        content: Text('You will permanently remove this item'),
        primaryButton: PrimaryButton(
          onPressed: () {
            Navigator.of(context).pop();
            _stationBloc.add(DeleteStationButtonPressed(station: station));
          },
          text: 'Delete'
        ),
        secondaryButton: SecondaryButton(
          onPressed: () => Navigator.of(context).pop(),
          text: 'Cancel'
        ),
      )
    );
  }
  

  @override
  Widget build(BuildContext context) {
    _stationBloc = BlocProvider.of<StationBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        // automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Station'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.add),
        onPressed: () async {
          final fetch = await Navigator
            .of(context)
            .pushNamed(
              StationFormScreen.routeName, 
              arguments: StationFormScreenArguments(
                title: 'Add Station', 
                action: 'create'));

          if(fetch != null && fetch)
            _stationBloc.add(LoadStationStarted());
        },
      ),
      body: BlocConsumer<StationBloc, StationState>(
        listener: (context, state) async {
          if(state is StationDeleteSuccess) {
            await customDialog.showDialog(
              context: context,
              builder: (_) => MessageDialog(
                message: state.message
              )
            );
            _stationBloc.add(LoadStationStarted());
          }
        },
        buildWhen: (prevState, state) {
          if(state is StationLoadStarted
          || state is StationLoadSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if(state is StationLoadStarted) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is StationLoadSuccess) {
            return ListView(
              padding: EdgeInsets.all(15.0),
              children: state.stations.map((station) => Card(
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.building,
                    color: Color(0xff5a5a5a),
                  ),
                  title: Text(
                    station.name,
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => deleteDialog(context, station),
                        icon: Icon(FontAwesomeIcons.trash),
                        iconSize: 18,
                      ),
                      // SizedBox(width: 8),
                      IconButton(
                        onPressed: () async {
                          final fetch = await Navigator
                            .of(context)
                            .pushNamed(
                              StationFormScreen.routeName, 
                              arguments: StationFormScreenArguments(
                                title: 'Edit Station', 
                                action: 'edit',
                                station: station));
                          
                          if(fetch != null && fetch)
                          _stationBloc.add(LoadStationStarted());
                        },
                        icon: Icon(FontAwesomeIcons.solidEdit),
                        iconSize: 18,
                      )
                    ],
                  ),
                ),
              )).toList()
            );
          } else {
            return Container();
          }
          
        }
      )
    );
  }
}