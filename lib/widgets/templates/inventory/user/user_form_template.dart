import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpUserForm extends StatefulWidget {
  final String title;
  final String action;
  final User user;

  TmpUserForm({@required this.title, @required this.action, this.user})
      : assert(title != null && title.isNotEmpty),
        assert(action != null && action.isNotEmpty);

  @override
  _TmpUserFormState createState() => _TmpUserFormState();
}

class _TmpUserFormState extends State<TmpUserForm> {
  final _formKey = GlobalKey<FormState>();

  UserFormBloc _userFormBloc;
  TextEditingController _nameCtrl;
  TextEditingController _emailCtrl;
  TextEditingController _passwordCtrl;
  String _selectedRole;
  List<String> _availableRole = [
    'Admin',
    'Operator',
    'Staff',
  ];

  @override
  void initState() {
    super.initState();
    _userFormBloc = BlocProvider.of<UserFormBloc>(context);

    _nameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();

    if (widget.user != null) {
      _nameCtrl.text = widget.user.name;
      _selectedRole = widget.user.role;
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
            backgroundColor: Colors.blueAccent[700],
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: BlocListener<UserFormBloc, UserFormState>(
            listener: (context, state) async {
              if (state is UserFormSubmitSuccess) {
                await customDialog.showDialog(
                    context: context,
                    builder: (_) => MessageDialog(message: state.message));
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
                                      color: Colors.blue[600], width: 1),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.blue[600], width: 1),
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                            if (widget.action != 'edit')
                              Container(
                                padding: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  controller: _emailCtrl,
                                  decoration: InputDecoration(
                                      labelText: 'Email',
                                      filled: true,
                                      fillColor: Colors.white,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue[600], width: 1),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue[600], width: 1),
                                      )),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            SizedBox(height: 20),
                            DropdownButtonFormField<String>(
                              value: _selectedRole,
                              items: _availableRole.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                  labelText: 'Role',
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue[600], width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue[600], width: 1),
                                  )),
                              onChanged: (value) =>
                                  setState(() => _selectedRole = value),
                              validator: (value) {
                                if (value == null) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            if (widget.action != 'edit')
                              TextFormField(
                                controller: _passwordCtrl,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: 'Password',
                                    filled: true,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue[600], width: 1),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.blue[600], width: 1),
                                    )),
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
                    BlocBuilder<UserFormBloc, UserFormState>(
                        builder: (context, state) {
                      if (state is UserFormSubmitInProgress) {
                        return Container(
                            height: 55,
                            width: double.infinity,
                            child: RaisedButton(
                                onPressed: () {},
                                elevation: 0,
                                color: Colors.blue[300],
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                )));
                      }
                      return Container(
                          height: 55,
                          width: double.infinity,
                          child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  if (widget.action == 'create') {
                                    _userFormBloc.add(AddUserButtonPressed(
                                        name: _nameCtrl.text,
                                        email: _emailCtrl.text,
                                        role: _selectedRole,
                                        password: _passwordCtrl.text));
                                  } else if (widget.action == 'edit') {
                                    assert(widget.user != null);
                                    User user = widget.user
                                      ..name = _nameCtrl.text
                                      ..role = _selectedRole;
                                    _userFormBloc
                                        .add(EditUserButtonPressed(user: user));
                                  }
                                }
                              },
                              elevation: 0,
                              color: Colors.blueAccent[700],
                              child: widget.action == 'create'
                                  ? Text('Create',
                                      style: TextStyle(color: Colors.white))
                                  : Text('Update',
                                      style: TextStyle(color: Colors.white))));
                    })
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
