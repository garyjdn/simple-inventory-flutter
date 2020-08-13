import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;

class TmpIncomingMain extends StatelessWidget {
  IncomingBloc _incomingBloc;

  Future deleteDialog(BuildContext ctx, Incoming incoming) async {
    return await showDialog(
      context: ctx,
      builder: (BuildContext context) => CustomDialog(
        title: 'Delete Incoming?',
        content: Text('You will permanently remove this incoming'),
        primaryButton: PrimaryButton(
          onPressed: () {
            Navigator.of(context).pop();
            _incomingBloc.add(DeleteIncomingButtonPressed(incoming: incoming));
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
    _incomingBloc = BlocProvider.of<IncomingBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        // automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Incoming'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.add),
        onPressed: () async {
          final fetch = await Navigator
            .of(context)
            .pushNamed(
              IncomingFormScreen.routeName, 
              arguments: IncomingFormScreenArguments(
                title: 'Add Incoming', 
                action: 'create'));

          if(fetch != null && fetch)
            _incomingBloc.add(LoadIncomingStarted());
        },
      ),
      body: BlocConsumer<IncomingBloc, IncomingState>(
        listener: (context, state) async {
          if(state is IncomingDeleteSuccess) {
            await customDialog.showDialog(
              context: context,
              builder: (_) => MessageDialog(
                message: state.message
              )
            );
            _incomingBloc.add(LoadIncomingStarted());
          }
        },
        buildWhen: (prevState, state) {
          if(state is IncomingLoadStarted
          || state is IncomingLoadSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if(state is IncomingLoadStarted) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is IncomingLoadSuccess) {

            return ListView(
              padding: EdgeInsets.fromLTRB(15.0, 15, 15, 55),
              children: state.incomings.map((incoming) => 
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
                                Text(incoming.item.name),
                                SizedBox(height: 5),
                                Text(DateFormat('dd/MM/yyyy').format(incoming.date)),
                              ],
                            ),
                            Column(
                              children: <Widget>[
                                Text(incoming.amount.toString()),
                                SizedBox(height: 5),
                                Text(incoming.item.unit.name)
                              ],
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  onPressed: () => deleteDialog(context, incoming),
                                  icon: Icon(FontAwesomeIcons.trash),
                                  iconSize: 18,
                                ),
                                // SizedBox(width: 8),
                                IconButton(
                                  onPressed: () async {
                                    final fetch = await Navigator
                                      .of(context)
                                      .pushNamed(
                                        IncomingFormScreen.routeName, 
                                        arguments: IncomingFormScreenArguments(
                                          title: 'Edit Incoming', 
                                          action: 'edit',
                                          incoming: incoming));
                                    
                                    if(fetch != null && fetch)
                                    _incomingBloc.add(LoadIncomingStarted());
                                  },
                                  icon: Icon(FontAwesomeIcons.solidEdit),
                                  iconSize: 18,
                                )
                              ],
                            )
                          ],
                        ),
                        Divider(),
                        Text(incoming.supplier.name)
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
              //       incoming.item.name,
              //       style: Theme.of(context).textTheme.bodyText2
              //     ),
              //     trailing: Row(
              //       mainAxisSize: MainAxisSize.min,
              //       children: <Widget>[
              //         IconButton(
              //           onPressed: () => deleteDialog(context, incoming),
              //           icon: Icon(FontAwesomeIcons.trash),
              //           iconSize: 18,
              //         ),
              //         // SizedBox(width: 8),
              //         IconButton(
              //           onPressed: () async {
              //             final fetch = await Navigator
              //               .of(context)
              //               .pushNamed(
              //                 IncomingFormScreen.routeName, 
              //                 arguments: IncomingFormScreenArguments(
              //                   title: 'Edit Incoming', 
              //                   action: 'edit',
              //                   incoming: incoming));
                          
              //             if(fetch != null && fetch)
              //             _incomingBloc.add(LoadIncomingStarted());
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