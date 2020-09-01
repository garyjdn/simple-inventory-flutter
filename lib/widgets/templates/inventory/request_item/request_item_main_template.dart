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

class TmpRequestItemMain extends StatefulWidget {
  @override
  _TmpRequestItemMainState createState() => _TmpRequestItemMainState();
}

class _TmpRequestItemMainState extends State<TmpRequestItemMain> {
  RequestItemBloc _requestItemBloc;
  TextEditingController _searchCtrl;
  List<RequestItem> filteredRequest;
  Timer _debounce;

  Future deleteDialog(BuildContext ctx, RequestItem requestItem) async {
    return await showDialog(
        context: ctx,
        builder: (BuildContext context) => CustomDialog(
              title: 'Delete RequestItem?',
              content: Text('You will permanently remove this item'),
              primaryButton: PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _requestItemBloc.add(DeleteRequestItemButtonPressed(
                        requestItem: requestItem));
                  },
                  text: 'Delete'),
              secondaryButton: SecondaryButton(
                  onPressed: () => Navigator.of(context).pop(), text: 'Cancel'),
            ));
  }

  search(List<RequestItem> source, String keyword) {
    List<RequestItem> requests = [
      ...source.where((request) {
        return request.requestUser.name
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            request.station.name.toLowerCase().contains(keyword.toLowerCase());
      }).toList()
    ];
    if (mounted) setState(() => filteredRequest = requests);
  }

  Future confirmDialog(BuildContext ctx, String action) async {
    return await showDialog(
        context: ctx,
        builder: (BuildContext context) => CustomDialog(
              title: '$action Request Item?',
              content: Container(),
              primaryButton: PrimaryButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  text: '$action'),
              secondaryButton: SecondaryButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  text: 'Cancel'),
            ));
  }

  Future<dynamic> showForm(
    BuildContext context,
    User user,
    List<Station> stations,
    RequestItemBloc requestItemBloc,
  ) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => RequestModal(
              user: user,
              stations: stations,
              requestItemBloc: requestItemBloc,
            ));
  }

  @override
  Widget build(BuildContext context) {
    _requestItemBloc = BlocProvider.of<RequestItemBloc>(context);

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, authState) {
      if (authState is AuthenticationSuccess) {
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
                leading: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.arrow_back_ios),
                ),
                title: Text('Request'),
                centerTitle: true,
              ),
              floatingActionButton: authState.user.role == 'Staff'
                  ? BlocBuilder<RequestItemBloc, RequestItemState>(
                      builder: (context, state) {
                      if (state is RequestItemLoadSuccess) {
                        return FloatingActionButton(
                          backgroundColor: Color(0XFF133EAE),
                          child: Icon(Icons.add),
                          onPressed: () async {
                            showForm(context, authState.user, state.stations,
                                _requestItemBloc);
                            // _requestItemBloc.add(AddRequestItemButtonPressed(user: authState.user, station));
                          },
                        );
                      } else {
                        return Container();
                      }
                    })
                  : null,
              body: BlocConsumer<RequestItemBloc, RequestItemState>(
                  listener: (context, state) async {
                if (state is RequestItemSubmitSuccess) {
                  await customDialog.showDialog(
                      context: context,
                      builder: (_) => MessageDialog(message: state.message));
                  await Navigator.of(context).pushNamed(
                      RequestItemDetailMainScreen.routeName,
                      arguments: state.requestItem);
                  _requestItemBloc
                      .add(LoadRequestItemStarted(user: authState.user));
                } else if (state is RequestItemDeleteSuccess) {
                  await customDialog.showDialog(
                      context: context,
                      builder: (_) => MessageDialog(message: state.message));
                  _requestItemBloc
                      .add(LoadRequestItemStarted(user: authState.user));
                }
                if (state is RequestItemLoadSuccess) {
                  filteredRequest = state.requestItems;
                }
              }, buildWhen: (prevState, state) {
                if (state is RequestItemLoadStarted ||
                    state is RequestItemLoadSuccess) {
                  return true;
                }
                return false;
              }, builder: (context, state) {
                if (state is RequestItemLoadStarted) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is RequestItemLoadSuccess) {
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
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
                            ),
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              if (_debounce?.isActive ?? false)
                                _debounce.cancel();
                              _debounce = Timer(
                                  const Duration(milliseconds: 500),
                                  () => search(state.requestItems, value));
                            } else {
                              setState(
                                  () => filteredRequest = state.requestItems);
                            }
                          },
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        ...filteredRequest
                            .map((requestItem) => InkWell(
                                  onTap: () async {
                                    final fetch = await Navigator.of(context)
                                        .pushNamed(
                                            RequestItemDetailMainScreen
                                                .routeName,
                                            arguments: requestItem);
                                    if (fetch != null && fetch) {
                                      _requestItemBloc.add(
                                          LoadRequestItemStarted(
                                              user: authState.user));
                                    }
                                  },
                                  child: Card(
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Text(requestItem
                                                          .requestUser.name),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Text(DateFormat(
                                                              'dd/MM/yyyy')
                                                          .format(requestItem
                                                              .date)),
                                                    ],
                                                  ),
                                                  Column(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 4,
                                                                horizontal: 8),
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                          color: requestItem
                                                                      .requestStatus ==
                                                                  RequestStatus
                                                                      .WAITING
                                                              ? Colors
                                                                  .yellow[700]
                                                              : requestItem
                                                                          .requestStatus ==
                                                                      RequestStatus
                                                                          .APPROVED
                                                                  ? Colors.green
                                                                  : Colors.red,
                                                        ),
                                                        child: Text(
                                                            requestItem
                                                                .requestStatusToString(
                                                                    requestItem
                                                                        .requestStatus),
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 12)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              Divider(),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: <Widget>[
                                                  Text(
                                                      requestItem.station.name),
                                                ],
                                              )
                                            ]),
                                      )),
                                ))
                            .toList(),
                      ]);
                } else {
                  return Container();
                }
              })),
        );
      } else {
        return Container();
      }
    });
  }
}
