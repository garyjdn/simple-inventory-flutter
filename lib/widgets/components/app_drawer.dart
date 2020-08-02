import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/shared/shared.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppBloc _appBloc = BlocProvider.of<AppBloc>(context);
    AuthenticationBloc _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    return  BlocBuilder<AppBloc, AppState>(
      builder: (context, appState) {
        if(appState is AppInformationLoaded) {
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, authState) {
              if(authState is AuthenticationSuccess) {
                return Drawer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: ListView(
                          children: <Widget>[
                            DrawerHeader(
                              padding: EdgeInsets.all(0),
                              child: Container(
                                // height: 100,
                                padding: EdgeInsets.all(15),
                                width: double.infinity,
                                color: Colors.blue[200],
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    CircleAvatar(
                                      radius: 35.0,
                                      // backgroundColor: Colors.brown.shade800,
                                      child: Text('A', style: TextStyle(fontSize: 25)),
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      '${authState.user.name} - ${authState.user.role}' ,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      authState.user.email ?? 'No Email Registered',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      Helpers.formatDateUtil(
                                          DateTime.now().toIso8601String()),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed(UserMainScreen.routeName);
                              },
                              leading: Icon(
                                FontAwesomeIcons.users, 
                                size:21
                              ),
                              title: Text('User')
                            ),
                            ListTile(
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed(StationMainScreen.routeName);
                              },
                              leading: Icon(
                                FontAwesomeIcons.building,
                                size:21
                              ),
                              title: Text('Station')
                            ),
                            Divider(),
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.userAlt,
                                size:21
                              ),
                              title: Text('Profile')
                            ),
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.bookmark,
                                size:21
                              ),
                              title: Text('About')
                            ),
                            ListTile(
                              leading: Icon(
                                FontAwesomeIcons.signOutAlt,
                                size:21
                              ),
                              title: Text('Logout'),
                              onTap: () {
                                _authenticationBloc.add(LoggedOut());
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40,
                        child: Center(
                          child: Text('V ${appState.version}')
                        )
                      )
                    ],
                  )
                );
              }
            }
          );
        }
      }
    );
  }
}