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

class TmpRequestItemDetailMain extends StatelessWidget {
  RequestItemDetailBloc _requestItemDetailBloc;
  RequestItem requestItem;

  TmpRequestItemDetailMain({this.requestItem});

  Future deleteDialog(
      BuildContext ctx, RequestItemDetail requestItemDetail) async {
    return await showDialog(
        context: ctx,
        builder: (BuildContext context) => CustomDialog(
              title: 'Delete Item Request?',
              content: Text('You will remove this item request'),
              primaryButton: PrimaryButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    _requestItemDetailBloc.add(
                        DeleteRequestItemDetailButtonPressed(
                            requestItemDetail: requestItemDetail));
                  },
                  text: 'Delete'),
              secondaryButton: SecondaryButton(
                  onPressed: () => Navigator.of(context).pop(), text: 'Cancel'),
            ));
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
      String action,
      List<Item> items,
      RequestItem requestItem,
      RequestItemDetailBloc requestItemDetailBloc,
      {RequestItemDetail requestItemDetail}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) => RequestItemModal(
              items: items,
              action: action,
              requestItem: requestItem,
              requestItemDetailBloc: requestItemDetailBloc,
              requestItemDetail: requestItemDetail,
            ));
  }

  @override
  Widget build(BuildContext context) {
    _requestItemDetailBloc = BlocProvider.of<RequestItemDetailBloc>(context);

    return Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.blueAccent[700],
          // automaticallyImplyLeading: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Request Detail'),
          centerTitle: true,
        ),
        floatingActionButton:
            BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, authState) {
          if (authState is AuthenticationSuccess) {
            return BlocBuilder<RequestItemDetailBloc, RequestItemDetailState>(
              builder: (context, state) {
                if (state is RequestItemDetailLoadSuccess &&
                    requestItem.requestStatus == RequestStatus.WAITING &&
                    authState.user.role == 'Staff') {
                  return FloatingActionButton(
                    backgroundColor: Colors.blue[300],
                    child: Icon(Icons.add),
                    onPressed: () {
                      showForm(context, 'Add', state.items, requestItem,
                          _requestItemDetailBloc);
                    },
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        }),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authState) {
          if (authState is AuthenticationSuccess) {
            return BlocConsumer<RequestItemDetailBloc, RequestItemDetailState>(
                listener: (context, state) async {
              if (state is RequestItemDetailSubmitSuccess) {
                await customDialog.showDialog(
                    context: context,
                    builder: (_) => MessageDialog(message: state.message));
                _requestItemDetailBloc.add(
                    LoadRequestItemDetailStarted(requestItem: requestItem));
              } else if (state is RequestItemDetailDeleteSuccess) {
                await customDialog.showDialog(
                    context: context,
                    builder: (_) => MessageDialog(message: state.message));
                _requestItemDetailBloc.add(
                    LoadRequestItemDetailStarted(requestItem: requestItem));
              } else if (state is RequestItemDetailSubmitStatusSuccess) {
                Navigator.of(context).pop(true);
              }
            }, buildWhen: (prevState, state) {
              if (state is RequestItemDetailLoadStarted ||
                  state is RequestItemDetailLoadSuccess) {
                return true;
              }
              return false;
            }, builder: (context, state) {
              if (state is RequestItemDetailLoadStarted) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is RequestItemDetailLoadSuccess) {
                return ListView(padding: EdgeInsets.all(15.0), children: [
                  Card(
                      elevation: 0,
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('PIC'),
                                      SizedBox(height: 3),
                                      Text('Station'),
                                      SizedBox(height: 3),
                                      Text('Date'),
                                      SizedBox(height: 3),
                                      Text('Status'),
                                    ],
                                  ),
                                  SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                          ':  ${requestItem.requestUser.name}'),
                                      SizedBox(height: 3),
                                      Text(':  ${requestItem.station.name}'),
                                      SizedBox(height: 3),
                                      Text(
                                          ':  ${DateFormat('dd/MM/yyyy').format(requestItem.date)}'),
                                      SizedBox(height: 3),
                                      Text(
                                          ':  ${requestItem.requestStatusToString(requestItem.requestStatus)}'),
                                    ],
                                  )
                                ],
                              ),
                              Divider(),
                              if (authState.user.role == 'Operator' &&
                                  requestItem.requestStatus ==
                                      RequestStatus.WAITING)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    RaisedButton(
                                      elevation: 0,
                                      onPressed: () async {
                                        bool confirm = await confirmDialog(
                                            context, 'Approve');
                                        if (confirm != null && confirm) {
                                          RequestItem ri = requestItem
                                            ..reviewUser = authState.user
                                            ..requestStatus =
                                                RequestStatus.APPROVED;
                                          _requestItemDetailBloc.add(
                                              EditRequestItemButtonPressed(
                                                  requestItem: ri));
                                        }
                                      },
                                      color: Colors.blue[300],
                                      child: Text('Approve',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    ),
                                    SizedBox(width: 5),
                                    RaisedButton(
                                      elevation: 0,
                                      onPressed: () async {
                                        bool confirm = await confirmDialog(
                                            context, 'Reject');
                                        if (confirm != null && confirm) {
                                          RequestItem ri = requestItem
                                            ..reviewUser = authState.user
                                            ..requestStatus =
                                                RequestStatus.REJECTED;
                                          _requestItemDetailBloc.add(
                                              EditRequestItemButtonPressed(
                                                  requestItem: ri));
                                        }
                                      },
                                      color: Colors.red[300],
                                      child: Text('Reject',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white)),
                                    )
                                  ],
                                )
                            ],
                          ))),
                  ...state.requestItemDetails
                      .map((requestItemDetail) => Card(
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
                                          Text(requestItemDetail.item.name),
                                          SizedBox(height: 5),
                                          Text(requestItemDetail
                                              .item.category.name),
                                        ],
                                      ),
                                      Column(
                                        children: <Widget>[
                                          Text(requestItemDetail.amount
                                              .toString()),
                                          SizedBox(height: 5),
                                          Text(requestItemDetail.item.unit.name)
                                        ],
                                      ),
                                      if (requestItem.requestStatus ==
                                              RequestStatus.WAITING &&
                                          authState.user.role == 'Staff')
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            IconButton(
                                              onPressed: () => deleteDialog(
                                                  context, requestItemDetail),
                                              icon:
                                                  Icon(FontAwesomeIcons.trash),
                                              iconSize: 18,
                                            ),
                                            // SizedBox(width: 8),
                                            IconButton(
                                              onPressed: () async {
                                                final fetch = await showForm(
                                                    context,
                                                    'Edit',
                                                    state.items,
                                                    requestItem,
                                                    _requestItemDetailBloc,
                                                    requestItemDetail:
                                                        requestItemDetail);
                                                if (fetch != null && fetch) {
                                                  _requestItemDetailBloc.add(
                                                      LoadRequestItemDetailStarted(
                                                          requestItem:
                                                              requestItem));
                                                }
                                              },
                                              icon: Icon(
                                                  FontAwesomeIcons.solidEdit),
                                              iconSize: 18,
                                            )
                                          ],
                                        )
                                    ],
                                  ),
                                ]),
                          )))
                      .toList(),
                ]);
              } else {
                return Container();
              }
            });
          } else {
            return Container();
          }
        }));
  }
}
