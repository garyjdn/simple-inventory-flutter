import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpIncomingForm extends StatefulWidget {
  final String title;
  final String action;
  final Incoming incoming;
  
  TmpIncomingForm({
    @required this.title,
    @required this.action,
    this.incoming
  }):
    assert(title != null && title.isNotEmpty),
    assert(action != null && action.isNotEmpty);

  @override
  _TmpIncomingFormState createState() => _TmpIncomingFormState();
}

class _TmpIncomingFormState extends State<TmpIncomingForm> {

  final _formKey = GlobalKey<FormState>();

  IncomingFormBloc _incomingFormBloc;
  DateTime _selectedDate = DateTime.now();
  Supplier _selectedSupplier;
  Item _selectedItem;
  TextEditingController _amountCtrl;

  @override
  void initState() {

    super.initState();
    _incomingFormBloc = BlocProvider.of<IncomingFormBloc>(context);
    
    _amountCtrl = TextEditingController();

    if(widget.incoming != null) {
      _selectedDate = widget.incoming.date;
      _selectedSupplier = widget.incoming.supplier;
      _selectedItem = widget.incoming.item;
      _amountCtrl.text = widget.incoming.amount.toString();
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
        body: BlocConsumer<IncomingFormBloc, IncomingFormState>(
          listener: (context, state) async {
            if(state is IncomingFormSubmitSuccess) {
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
            if(state is IncomingFormLoadInProgress
            || state is IncomingFormLoadSuccess) {
              return true;
            }
            return false;
          },
          builder: (context, state) {
            if(state is IncomingFormLoadInProgress) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if(state is IncomingFormLoadSuccess) {
              if(!state.suppliers.contains(_selectedSupplier)) {
                _selectedSupplier = state.suppliers[0];
              }
              if(!state.items.contains(_selectedItem)) {
                _selectedItem = state.items[0];
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
                              DropdownButtonFormField<Supplier>(
                                value: _selectedSupplier ?? state.suppliers[0],
                                items: state.suppliers.map((Supplier value) {
                                  return DropdownMenuItem<Supplier>(
                                    value: value,
                                    child: Text(value.name),
                                  );
                                }).toList(),
                                decoration: InputDecoration(
                                  labelText: 'Supplier',
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
                                onChanged: (value) => setState(() => _selectedSupplier = value),
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      BlocBuilder<IncomingFormBloc, IncomingFormState>(
                        builder: (context, state) {
                          if(state is IncomingFormSubmitInProgress) {
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
                          } else if(state is IncomingFormLoadSuccess) {
                            return Container(
                              height: 55,
                              width: double.infinity,
                              child: RaisedButton(
                                onPressed: () {
                                  if (_formKey.currentState.validate()) {
                                    if(widget.action == 'create') {
                                      _incomingFormBloc.add(AddIncomingButtonPressed(
                                        date: _selectedDate,
                                        amount: int.parse(_amountCtrl.text),
                                        supplier: _selectedSupplier ?? state.suppliers[0],
                                        item: _selectedItem?? state.items[0]));
                                    } else if(widget.action == 'edit') {
                                      assert(widget.incoming != null);
                                      Incoming incoming = widget.incoming
                                        ..date = _selectedDate
                                        ..amount = int.parse(_amountCtrl.text)
                                        ..supplier = _selectedSupplier
                                        ..item = _selectedItem;
                                      _incomingFormBloc.add(EditIncomingButtonPressed(incoming: incoming));
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