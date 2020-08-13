import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;

class TmpOutgoingMain extends StatelessWidget {
  OutgoingBloc _outgoingBloc;

  Future deleteDialog(BuildContext ctx, Outgoing outgoing) async {
    return await showDialog(
      context: ctx,
      builder: (BuildContext context) => CustomDialog(
        title: 'Delete Outgoing?',
        content: Text('You will permanently remove this outgoing'),
        primaryButton: PrimaryButton(
          onPressed: () {
            Navigator.of(context).pop();
            _outgoingBloc.add(DeleteOutgoingButtonPressed(outgoing: outgoing));
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
    _outgoingBloc = BlocProvider.of<OutgoingBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        // automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Outgoing'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.add),
        onPressed: () async {
          final fetch = await Navigator
            .of(context)
            .pushNamed(
              OutgoingFormScreen.routeName, 
              arguments: OutgoingFormScreenArguments(
                title: 'Add Outgoing', 
                action: 'create'));

          if(fetch != null && fetch)
            _outgoingBloc.add(LoadOutgoingStarted());
        },
      ),
      body: BlocConsumer<OutgoingBloc, OutgoingState>(
        listener: (context, state) async {
          if(state is OutgoingDeleteSuccess) {
            await customDialog.showDialog(
              context: context,
              builder: (_) => MessageDialog(
                message: state.message
              )
            );
            _outgoingBloc.add(LoadOutgoingStarted());
          }
        },
        buildWhen: (prevState, state) {
          if(state is OutgoingLoadStarted
          || state is OutgoingLoadSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if(state is OutgoingLoadStarted) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is OutgoingLoadSuccess) {

            return ListView(
              padding: EdgeInsets.fromLTRB(15.0, 15, 15, 55),
              children: state.outgoings.map((outgoing) => 
                Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(outgoing.item.name),
                                SizedBox(height: 5),
                                Text(DateFormat('dd/MM/yyyy').format(outgoing.date)),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(outgoing.amount.toString()),
                                SizedBox(height: 5),
                                Text(outgoing.item.unit.name)
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () => deleteDialog(context, outgoing),
                                  icon: Icon(FontAwesomeIcons.trash),
                                  iconSize: 18,
                                ),
                                // SizedBox(width: 8),
                                IconButton(
                                  onPressed: () async {
                                    final fetch = await Navigator
                                      .of(context)
                                      .pushNamed(
                                        OutgoingFormScreen.routeName, 
                                        arguments: OutgoingFormScreenArguments(
                                          title: 'Edit Outgoing', 
                                          action: 'edit',
                                          outgoing: outgoing));
                                    
                                    if(fetch != null && fetch)
                                    _outgoingBloc.add(LoadOutgoingStarted());
                                  },
                                  icon: Icon(FontAwesomeIcons.solidEdit),
                                  iconSize: 18,
                                )
                              ],
                            )
                          ],
                        ),
                        Divider(),
                        Text('${outgoing.user.name} - ${outgoing.station.name}')
                      ]
                      
                    ),
                  )
                )).toList(),
              // Card(
              //   elevation: 0,
              //   child: ListTile(
              //     leading: Icon(
              //       FontAwesomeIcons.box,
              //       color: Color(0xff5a5a5a),
              //     ),
              //     title: Text(
              //       outgoing.item.name,
              //       style: Theme.of(context).textTheme.bodyText2
              //     ),
              //     trailing: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: <Widget>[
              //         IconButton(
              //           onPressed: () => deleteDialog(context, outgoing),
              //           icon: Icon(FontAwesomeIcons.trash),
              //           iconSize: 18,
              //         ),
              //         // SizedBox(width: 8),
              //         IconButton(
              //           onPressed: () async {
              //             final fetch = await Navigator
              //               .of(context)
              //               .pushNamed(
              //                 OutgoingFormScreen.routeName, 
              //                 arguments: OutgoingFormScreenArguments(
              //                   title: 'Edit Outgoing', 
              //                   action: 'edit',
              //                   outgoing: outgoing));
                          
              //             if(fetch != null && fetch)
              //             _outgoingBloc.add(LoadOutgoingStarted());
              //           },
              //           icon: Icon(FontAwesomeIcons.solidEdit),
              //           iconSize: 18,
              //         )
              //       ],
              //     ),
              //   ),
              // )).toList()
            );
          } else {
            return Container();
          }
          
        }
      )
    );
  }
}