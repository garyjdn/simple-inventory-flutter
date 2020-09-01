import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpChangePassword extends StatefulWidget {
  @override
  _TmpChangePasswordState createState() => _TmpChangePasswordState();
}

class _TmpChangePasswordState extends State<TmpChangePassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _passwordCtrl;
  TextEditingController _retypeCtrl;
  ChangePasswordBloc _changePasswordBloc;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    super.initState();
    _changePasswordBloc = BlocProvider.of<ChangePasswordBloc>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _passwordCtrl = TextEditingController();
    _retypeCtrl = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
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
            title: Text('Change Password'),
            centerTitle: true,
          ),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _passwordCtrl,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0XFF133EAE), width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0XFF133EAE), width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field is required';
                      } else if (_retypeCtrl.text != value) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _retypeCtrl,
                    decoration: InputDecoration(
                      labelText: 'Retype Password',
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[600], width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blue[600], width: 1),
                      ),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'This field is required';
                      }
                      if (_passwordCtrl.text != value) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
                      listener: (context, state) async {
                    if (state is ChangePasswordSuccess) {
                      Navigator.of(context).pop();
                      await customDialog.showDialog(
                          context: context,
                          builder: (_) =>
                              MessageDialog(message: state.message));
                      _authenticationBloc.add(LoggedOut());
                    } else if (state is ChangePasswordFailed) {
                      await customDialog.showDialog(
                          context: context,
                          builder: (_) =>
                              MessageDialog(message: state.message));
                    }
                  }, buildWhen: (context, state) {
                    if (state is ChangePasswordInitial ||
                        state is ChangePasswordInProgress) {
                      return true;
                    }
                    return false;
                  }, builder: (context, state) {
                    if (state is ChangePasswordInProgress) {
                      return Container(
                          height: 55,
                          width: double.infinity,
                          child: RaisedButton(
                              onPressed: () {},
                              elevation: 0,
                              color: Color(0XFF133EAE),
                              child: SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )));
                    } else {
                      return Container(
                          height: 55,
                          width: double.infinity,
                          child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _changePasswordBloc.add(
                                      ChangePasswordButtonPressed(
                                          password: _passwordCtrl.text));
                                }
                              },
                              elevation: 0,
                              color: Color(0XFF133EAE),
                              child: Text('Change Password',
                                  style: TextStyle(color: Colors.white))));
                    }
                  })
                ],
              ),
            ),
          )),
    );
  }
}
