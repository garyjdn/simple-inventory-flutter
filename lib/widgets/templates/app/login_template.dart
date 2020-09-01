import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/shared/shared.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;

class TmpLogin extends StatefulWidget {
  @override
  _TmpLoginState createState() => _TmpLoginState();
}

class _TmpLoginState extends State<TmpLogin> {
  LoginBloc _loginBloc;
  AuthenticationBloc _authBloc;
  TextEditingController _emailCtrl;
  TextEditingController _passwordCtrl;

  bool _obscurePassword = true;
  bool _rememberMe = true;

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    _emailCtrl = TextEditingController();
    _passwordCtrl = TextEditingController();
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
          backgroundColor: Colors.transparent,
          body: LayoutBuilder(builder:
              (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: viewportConstraints.maxHeight,
                    ),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.white, Colors.blue[100]])),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Hero(
                                  tag: 'logo',
                                  child: Image.asset(
                                    Assets.logo,
                                    width: 300,
                                    height: 150,
                                  )),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text('Inventory',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .copyWith(color: Color(0XFF133EAE))),
                                  Text('App',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .copyWith(color: Color(0xFFED1B26)))
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20),
                          Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                side:
                                    BorderSide(color: Colors.white70, width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Column(
                                  children: <Widget>[
                                    TextFormField(
                                      controller: _emailCtrl,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        labelText: 'Email',
                                      ),
                                    ),
                                    TextFormField(
                                      controller: _passwordCtrl,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        labelText: 'Password',
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                    Row(
                                      children: <Widget>[
                                        CustomCheckBox(
                                          color: Color(0xFF888888),
                                          size: 22.0,
                                          isMarked: _rememberMe,
                                          onChange: (bool value) {
                                            setState(() {
                                              _rememberMe = value;
                                            });
                                          },
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          'Remember Me',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText2
                                              .copyWith(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    BlocConsumer<LoginBloc, LoginState>(
                                        listener: (context, state) {
                                      if (state is LoginSuccess) {
                                        _authBloc.add(LoggedIn(
                                            user: state.user,
                                            // token: state.user.sessionId,
                                            rememberMe: _rememberMe));
                                      } else if (state is LoginFailure) {
                                        customDialog.showDialog(
                                            context: context,
                                            builder: (_) => MessageDialog(
                                                message: state.errorMsg));
                                      }
                                    }, builder: (context, state) {
                                      return Container(
                                          width: double.infinity,
                                          child: RaisedButton(
                                              elevation: 0,
                                              color: Color(0XFF133EAE),
                                              onPressed: () {
                                                if (!(state is LoginLoading)) {
                                                  _loginBloc.add(
                                                      LoginButtonPressed(
                                                          email:
                                                              _emailCtrl.text,
                                                          password:
                                                              _passwordCtrl
                                                                  .text,
                                                          rememberMe:
                                                              _rememberMe));
                                                }
                                              },
                                              child: Container(
                                                height: 40,
                                                child: Center(
                                                  child: state is LoginLoading
                                                      ? SizedBox(
                                                          width: 20,
                                                          height: 20,
                                                          child:
                                                              CircularProgressIndicator(
                                                            valueColor:
                                                                new AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors
                                                                        .white),
                                                          ),
                                                        )
                                                      : Text('Login',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                ),
                                              )));
                                    }),
                                  ],
                                ),
                              )),
                          SizedBox(height: 50)
                        ],
                      ),
                    )));
          })),
    );
  }
}
