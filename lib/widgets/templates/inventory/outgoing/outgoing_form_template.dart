import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpOutgoingForm extends StatefulWidget {
  final String title;
  final String action;
  final Outgoing outgoing;
  
  TmpOutgoingForm({
    @required this.title,
    @required this.action,
    this.outgoing
  }):
    assert(title != null && title.isNotEmpty),
    assert(action != null && action.isNotEmpty);

  @override
  _TmpOutgoingFormState createState() => _TmpOutgoingFormState();
}

class _TmpOutgoingFormState extends State<TmpOutgoingForm> {

  final _formKey = GlobalKey<FormState>();

  OutgoingFormBloc _outgoingFormBloc;
  DateTime _selectedDate = DateTime.now();
  User _selectedUser;
  Station _selectedStation;
  Item _selectedItem;
  TextEditingController _amountCtrl;

  @override
  void initState() {

    super.initState();
    _outgoingFormBloc = BlocProvider.of<OutgoingFormBloc>(context);
    
    _amountCtrl = TextEditingController();

    if(widget.outgoing != null) {
      _selectedDate = widget.outgoing.date;
      _selectedUser = widget.outgoing.user;
      _selectedStation = widget.outgoing.station;
      _selectedItem = widget.outgoing.item;
      _amountCtrl.text = widget.outgoing.amount.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: BlocConsumer<OutgoingFormBloc, OutgoingFormState>(
          listener: (context, state) async {
            if(state is OutgoingFormSubmitSuccess) {
              await customDialog.showDialog(
                context: context,
                builder: (_) => MessageDialog(
                  message: state.message
                )
              );
              Navigator.of(context).pop(true);
            }
          },
          buildWhen: (prevState, state) {
            if(state is OutgoingFormLoadInProgress
            || state is OutgoingFormLoadSuccess) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if(state is OutgoingFormLoadInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is OutgoingFormLoadSuccess) {
              if(!state.items.contains(_selectedItem)) {
                _selectedItem = state.items[0];
              }
              if(!state.stations.contains(_selectedStation)) {
                _selectedStation = state.stations[0];
              }
              if(!state.users.contains(_selectedUser)) {
                _selectedUser = state.users[0];
              }
              return Container(
                height: deviceSize.height,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 10),
                              DateTimeField(
                                decoration: InputDecoration(
                                  labelText: 'Date',
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  )
                                ),
                                initialValue: _selectedDate,
                                format: DateFormat("yyyy-MM-dd"),
                                onShowPicker: (context, currentValue) {
                                  return showDatePicker(
                                      context: context,
                                      firstDate: DateTime(1900),
                                      initialDate: currentValue ?? DateTime.now(),
                                      lastDate: DateTime(2100));
                                },
                                onChanged: (DateTime dt) => _selectedDate = dt,
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              DropdownButtonFormField<User>(
                                value: _selectedUser ?? state.users[0],
                                items: state.users.map((User value) {
                                  return DropdownMenuItem<User>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: 'User',
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  )
                                ),
                                onChanged: (value) => setState(() => _selectedUser = value),
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              DropdownButtonFormField<Item>(
                                value: _selectedItem ?? state.items[0],
                                items: state.items.map((Item value) {
                                  return DropdownMenuItem<Item>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: 'Item',
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  )
                                ),
                                onChanged: (value) => setState(() => _selectedItem = value),
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 5),
                              Container(
                                width: double.infinity,
                                child: Text(
                                  'Available stock: ${_selectedItem.stock.toString()}',
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(height: 20),
                              DropdownButtonFormField<Station>(
                                value: _selectedStation ?? state.stations[0],
                                items: state.stations.map((Station value) {
                                  return DropdownMenuItem<Station>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: 'Station',
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  )
                                ),
                                onChanged: (value) => setState(() => _selectedStation = value),
                                validator: (value) {
                                  if (value == null) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20),
                              TextFormField(
                                controller: _amountCtrl,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Amount',
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.blue[600],
                                      width: 1
                                    ),
                                  ),
                                ),
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'This field is required';
                                  }
                                  if (int.parse(value) > _selectedItem.stock) {
                                    return 'Insufficient stock';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<OutgoingFormBloc, OutgoingFormState>(
                        builder: (context, state) {
                          if(state is OutgoingFormSubmitInProgress) {
                            return Container(
                              height: 55,
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () {},
                                elevation: 0,
                                color: Colors.blue[300],
                                child: SizedBox(
                                  width:20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                                  ),
                                )
                              )
                            );
                          } else if(state is OutgoingFormLoadSuccess) {
                            return Container(
                              height: 55,
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    if(widget.action == 'create') {
                                      _outgoingFormBloc.add(AddOutgoingButtonPressed(
                                        date: _selectedDate,
                                        amount: int.parse(_amountCtrl.text),
                                        user: _selectedUser ?? state.users[0],
                                        station: _selectedStation ?? state.stations[0],
                                        item: _selectedItem?? state.items[0]));
                                    } else if(widget.action == 'edit') {
                                      assert(widget.outgoing != null);
                                      int oldOutgoingAmount = widget.outgoing.amount;
                                      Outgoing outgoing = widget.outgoing
                                        ..date = _selectedDate
                                        ..amount = int.parse(_amountCtrl.text)
                                        ..user = _selectedUser
                                        ..station = _selectedStation
                                        ..item = _selectedItem;
                                      _outgoingFormBloc.add(EditOutgoingButtonPressed(
                                        outgoing: outgoing,
                                        oldAmount: oldOutgoingAmount));
                                    }
                                  }
                                },
                                elevation: 0,
                                color: Colors.blue[300],
                                child: widget.action == 'create'
                                  ? Text('Create', style: TextStyle(color: Colors.white))
                                  : Text('Update', style: TextStyle(color: Colors.white))
                              )
                            );
                          } else {
                            return Container();
                          }
                          
                        }
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }, 
        )
      ),
    );
  }
}