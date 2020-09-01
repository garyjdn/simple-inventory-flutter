import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpItemForm extends StatefulWidget {
  final String title;
  final String action;
  final Item item;

  TmpItemForm({@required this.title, @required this.action, this.item})
      : assert(title != null && title.isNotEmpty),
        assert(action != null && action.isNotEmpty);

  @override
  _TmpItemFormState createState() => _TmpItemFormState();
}

class _TmpItemFormState extends State<TmpItemForm> {
  final _formKey = GlobalKey<FormState>();

  ItemFormBloc _itemFormBloc;
  TextEditingController _nameCtrl;
  TextEditingController _stockCtrl;
  Category _selectedCategory;
  Unit _selectedUnit;

  @override
  void initState() {
    super.initState();
    _itemFormBloc = BlocProvider.of<ItemFormBloc>(context);

    _nameCtrl = TextEditingController();
    _stockCtrl = TextEditingController();

    if (widget.item != null) {
      _nameCtrl.text = widget.item.name;
      _selectedCategory = widget.item.category;
      _selectedUnit = widget.item.unit;
      _stockCtrl.text = widget.item.stock.toString();
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
            backgroundColor: Color(0XFF133EAE),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: BlocConsumer<ItemFormBloc, ItemFormState>(
            listener: (context, state) async {
              if (state is ItemFormSubmitSuccess) {
                await customDialog.showDialog(
                    context: context,
                    builder: (_) => MessageDialog(message: state.message));
                Navigator.of(context).pop(true);
              }
            },
            buildWhen: (prevState, state) {
              if (state is ItemFormLoadInProgress ||
                  state is ItemFormLoadSuccess) {
                return true;
              }
              return false;
            },
            builder: (context, state) {
              if (state is ItemFormLoadInProgress) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ItemFormLoadSuccess) {
                if (!state.categories.contains(_selectedCategory)) {
                  _selectedCategory = state.categories[0];
                }
                if (!state.units.contains(_selectedUnit)) {
                  _selectedUnit = state.units[0];
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
                                TextFormField(
                                  controller: _nameCtrl,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0XFF133EAE), width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color(0XFF133EAE), width: 1),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                DropdownButtonFormField<Category>(
                                  value:
                                      _selectedCategory ?? state.categories[0],
                                  items: state.categories.map((Category value) {
                                    return DropdownMenuItem<Category>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                      labelText: 'Category',
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFF133EAE), width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFF133EAE), width: 1),
                                      )),
                                  onChanged: (value) =>
                                      setState(() => _selectedCategory = value),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20),
                                DropdownButtonFormField<Unit>(
                                  value: _selectedUnit ?? state.units[0],
                                  items: state.units.map((Unit value) {
                                    return DropdownMenuItem<Unit>(
                                      value: value,
                                      child: Text(value.name),
                                    );
                                  }).toList(),
                                  decoration: InputDecoration(
                                      labelText: 'Unit',
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFF133EAE), width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0XFF133EAE), width: 1),
                                      )),
                                  onChanged: (value) =>
                                      setState(() => _selectedUnit = value),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        BlocBuilder<ItemFormBloc, ItemFormState>(
                            builder: (context, state) {
                          if (state is ItemFormSubmitInProgress) {
                            return Container(
                                height: 55,
                                width: double.infinity,
                                child: RaisedButton(
                                    onPressed: () {},
                                    elevation: 0,
                                    color: Colors.blueAccent[700],
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    )));
                          } else if (state is ItemFormLoadSuccess) {
                            return Container(
                                height: 55,
                                width: double.infinity,
                                child: RaisedButton(
                                    onPressed: () {
                                      if (_formKey.currentState.validate()) {
                                        if (widget.action == 'create') {
                                          _itemFormBloc.add(
                                              AddItemButtonPressed(
                                                  name: _nameCtrl.text,
                                                  category: _selectedCategory ??
                                                      state.categories[0],
                                                  unit: _selectedUnit ??
                                                      state.units[0]));
                                        } else if (widget.action == 'edit') {
                                          assert(widget.item != null);
                                          Item item = widget.item
                                            ..name = _nameCtrl.text
                                            ..category = _selectedCategory
                                            ..unit = _selectedUnit;
                                          // ..stock =
                                          //     int.parse(_stockCtrl.text);
                                          _itemFormBloc.add(
                                              EditItemButtonPressed(
                                                  item: item));
                                        }
                                      }
                                    },
                                    elevation: 0,
                                    color: Color(0XFF133EAE),
                                    child: widget.action == 'create'
                                        ? Text('Create',
                                            style:
                                                TextStyle(color: Colors.white))
                                        : Text('Update',
                                            style: TextStyle(
                                                color: Colors.white))));
                          } else {
                            return Container();
                          }
                        })
                      ],
                    ),
                  ),
                );
              } else {
                return Container();
              }
            },
          )),
    );
  }
}
