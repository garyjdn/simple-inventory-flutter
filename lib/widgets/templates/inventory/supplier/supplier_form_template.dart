import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpSupplierForm extends StatefulWidget {
  final String title;
  final String action;
  final Supplier supplier;
  
  TmpSupplierForm({
    @required this.title,
    @required this.action,
    this.supplier
  }):
    assert(title != null && title.isNotEmpty),
    assert(action != null && action.isNotEmpty);

  @override
  _TmpSupplierFormState createState() => _TmpSupplierFormState();
}

class _TmpSupplierFormState extends State<TmpSupplierForm> {

  final _formKey = GlobalKey<FormState>();

  SupplierFormBloc _supplierFormBloc;
  TextEditingController _nameCtrl;
  TextEditingController _phoneCtrl;
  TextEditingController _addressCtrl;

  @override
  void initState() {
    super.initState();
    _supplierFormBloc = BlocProvider.of<SupplierFormBloc>(context);
    
    _nameCtrl = TextEditingController();
    _phoneCtrl = TextEditingController();
    _addressCtrl = TextEditingController();

    if(widget.supplier != null) {
      _nameCtrl.text = widget.supplier.name;
      _phoneCtrl.text = widget.supplier.phone;
      _addressCtrl.text = widget.supplier.address;
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
        body: BlocListener<SupplierFormBloc, SupplierFormState>(
          listener: (context, state) async {
            if(state is SupplierFormSubmitSuccess) {
              await customDialog.showDialog(
                context: context,
                builder: (_) => MessageDialog(
                  message: state.message
                )
              );
              Navigator.of(context).pop(true);
            }
          },
          child: Container(
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
                          TextFormField(
                            controller: _nameCtrl,
                            decoration: InputDecoration(
                              labelText: 'Name',
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _phoneCtrl,
                            decoration: InputDecoration(
                              labelText: 'Phone',
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _addressCtrl,
                            maxLines: 4,
                            decoration: InputDecoration(
                              labelText: 'Address',
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
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                  BlocBuilder<SupplierFormBloc, SupplierFormState>(
                    builder: (context, state) {
                      if(state is SupplierFormSubmitInProgress) {
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
                      }
                      return Container(
                        height: 55,
                        width: double.infinity,
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              if(widget.action == 'create') {
                                _supplierFormBloc.add(AddSupplierButtonPressed(
                                  name: _nameCtrl.text,
                                  phone: _phoneCtrl.text,
                                  address: _addressCtrl.text));
                              } else if(widget.action == 'edit') {
                                assert(widget.supplier != null);
                                Supplier supplier = widget.supplier
                                  ..name = _nameCtrl.text
                                  ..phone = _phoneCtrl.text
                                  ..address = _addressCtrl.text;
                                _supplierFormBloc.add(EditSupplierButtonPressed(supplier: supplier));
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
                    }
                  )
                ],
              ),
            ),
          ),
        )
      ),
    );
  }
}