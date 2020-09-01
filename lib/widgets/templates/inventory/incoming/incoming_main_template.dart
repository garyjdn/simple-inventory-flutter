import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;

class TmpIncomingMain extends StatefulWidget {
  @override
  _TmpIncomingMainState createState() => _TmpIncomingMainState();
}

class _TmpIncomingMainState extends State<TmpIncomingMain> {
  IncomingBloc _incomingBloc;
  TextEditingController _searchCtrl;
  List<Incoming> filteredIncomings;
  Timer _debounce;

  Future deleteDialog(BuildContext ctx, Incoming incoming) async {
    return await showDialog(
        context: ctx,
        builder: (BuildContext context) => CustomDialog(
              title: 'Delete Incoming?',
              content: Text('You will permanently remove this incoming'),
              primaryButton: PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _incomingBloc
                        .add(DeleteIncomingButtonPressed(incoming: incoming));
                  },
                  text: 'Delete'),
              secondaryButton: SecondaryButton(
                  onPressed: () => Navigator.of(context).pop(), text: 'Cancel'),
            ));
  }

  search(List<Incoming> source, String keyword) {
    List<Incoming> incomings = [
      ...source.where((incoming) {
        return incoming.item.name
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            incoming.supplier.name
                .toLowerCase()
                .contains(keyword.toLowerCase());
      }).toList()
    ];
    if (mounted) setState(() => filteredIncomings = incomings);
  }

  @override
  Widget build(BuildContext context) {
    _incomingBloc = BlocProvider.of<IncomingBloc>(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            backgroundColor: Color(0XFF133EAE),
            // automaticallyImplyLeading: true,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text('Incoming'),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Color(0XFF133EAE),
            child: Icon(Icons.add),
            onPressed: () async {
              final fetch = await Navigator.of(context).pushNamed(
                  IncomingFormScreen.routeName,
                  arguments: IncomingFormScreenArguments(
                      title: 'Add Incoming', action: 'create'));

              if (fetch != null && fetch)
                _incomingBloc.add(LoadIncomingStarted());
            },
          ),
          body: BlocConsumer<IncomingBloc, IncomingState>(
              listener: (context, state) async {
            if (state is IncomingDeleteSuccess) {
              await customDialog.showDialog(
                  context: context,
                  builder: (_) => MessageDialog(message: state.message));
              _incomingBloc.add(LoadIncomingStarted());
            }
            if (state is IncomingLoadSuccess) {
              filteredIncomings = state.incomings;
            }
          }, buildWhen: (prevState, state) {
            if (state is IncomingLoadStarted || state is IncomingLoadSuccess) {
              return true;
            }
            return false;
          }, builder: (context, state) {
            if (state is IncomingLoadStarted) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is IncomingLoadSuccess) {
              return ListView(
                padding: EdgeInsets.fromLTRB(15.0, 15, 15, 55),
                children: [
                  TextFormField(
                    controller: _searchCtrl,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white, width: 1),
                      ),
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty) {
                        if (_debounce?.isActive ?? false) _debounce.cancel();
                        _debounce = Timer(const Duration(milliseconds: 500),
                            () => search(state.incomings, value));
                      } else {
                        setState(() => filteredIncomings = state.incomings);
                      }
                    },
                  ),
                  SizedBox(height: 15),
                  ...filteredIncomings
                      .map((incoming) => Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(incoming.item.name),
                                          SizedBox(height: 5),
                                          Text(DateFormat('dd/MM/yyyy')
                                              .format(incoming.date)),
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
                                            onPressed: () =>
                                                deleteDialog(context, incoming),
                                            icon: Icon(FontAwesomeIcons.trash),
                                            iconSize: 18,
                                          ),
                                          // SizedBox(width: 8),
                                          IconButton(
                                            onPressed: () async {
                                              final fetch = await Navigator.of(
                                                      context)
                                                  .pushNamed(
                                                      IncomingFormScreen
                                                          .routeName,
                                                      arguments:
                                                          IncomingFormScreenArguments(
                                                              title:
                                                                  'Edit Incoming',
                                                              action: 'edit',
                                                              incoming:
                                                                  incoming));

                                              if (fetch != null && fetch)
                                                _incomingBloc
                                                    .add(LoadIncomingStarted());
                                            },
                                            icon: Icon(
                                                FontAwesomeIcons.solidEdit),
                                            iconSize: 18,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Divider(),
                                  Text(incoming.supplier.name)
                                ]),
                          )))
                      .toList(),
                ],
              );
            } else {
              return Container();
            }
          })),
    );
  }
}
