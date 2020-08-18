import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;

class TmpUnitMain extends StatelessWidget {
  UnitBloc _unitBloc;

  Future deleteDialog(BuildContext ctx, Unit unit) async {
    return await showDialog(
        context: ctx,
        builder: (BuildContext context) => CustomDialog(
              title: 'Delete Unit?',
              content: Text('You will permanently remove this item'),
              primaryButton: PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _unitBloc.add(DeleteUnitButtonPressed(unit: unit));
                  },
                  text: 'Delete'),
              secondaryButton: SecondaryButton(
                  onPressed: () => Navigator.of(context).pop(), text: 'Cancel'),
            ));
  }

  @override
  Widget build(BuildContext context) {
    _unitBloc = BlocProvider.of<UnitBloc>(context);

    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[700],
          // automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Unit'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blueAccent[700],
          child: Icon(Icons.add),
          onPressed: () async {
            final fetch = await Navigator.of(context).pushNamed(
                UnitFormScreen.routeName,
                arguments: UnitFormScreenArguments(
                    title: 'Add Unit', action: 'create'));

            if (fetch != null && fetch) _unitBloc.add(LoadUnitStarted());
          },
        ),
        body:
            BlocConsumer<UnitBloc, UnitState>(listener: (context, state) async {
          if (state is UnitDeleteSuccess) {
            await customDialog.showDialog(
                context: context,
                builder: (_) => MessageDialog(message: state.message));
            _unitBloc.add(LoadUnitStarted());
          }
        }, buildWhen: (prevState, state) {
          if (state is UnitLoadStarted || state is UnitLoadSuccess) {
            return true;
          }
          return false;
        }, builder: (context, state) {
          if (state is UnitLoadStarted) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UnitLoadSuccess) {
            return ListView(
                padding: EdgeInsets.all(15.0),
                children: state.units
                    .map((unit) => Card(
                          elevation: 0,
                          child: ListTile(
                            leading: Icon(
                              FontAwesomeIcons.unity,
                              color: Color(0xff5a5a5a),
                            ),
                            title: Text(unit.name,
                                style: Theme.of(context).textTheme.bodyText2),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () => deleteDialog(context, unit),
                                  icon: Icon(FontAwesomeIcons.trash),
                                  iconSize: 18,
                                ),
                                // SizedBox(width: 8),
                                IconButton(
                                  onPressed: () async {
                                    final fetch = await Navigator.of(context)
                                        .pushNamed(UnitFormScreen.routeName,
                                            arguments: UnitFormScreenArguments(
                                                title: 'Edit Unit',
                                                action: 'edit',
                                                unit: unit));

                                    if (fetch != null && fetch)
                                      _unitBloc.add(LoadUnitStarted());
                                  },
                                  icon: Icon(FontAwesomeIcons.solidEdit),
                                  iconSize: 18,
                                )
                              ],
                            ),
                          ),
                        ))
                    .toList());
          } else {
            return Container();
          }
        }));
  }
}
