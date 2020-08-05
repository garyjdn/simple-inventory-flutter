import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/shared/shared.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  User user;


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
                            StreamBuilder<QuerySnapshot>(
                              stream: Firestore.instance.collection('users').snapshots(),
                              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                if(snapshot.connectionState != ConnectionState.waiting) {
                                  List<DocumentSnapshot> ds = snapshot.data.documents.where((DocumentSnapshot doc) => doc.documentID == authState.user.id).toList();
                                  user = User.fromDocumentSnapshot(ds[0]);
                                  
                                  return DrawerHeader(
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
                                            child: ClipOval(
                                              child: user.image != null && user.image.isNotEmpty
                                              ? Image.network(user.image)
                                              : Icon(Icons.person, size: 35)
                                            ),
                                            radius: 35,
                                          ),
                                          // CircleAvatar(
                                          //   radius: 35.0,
                                          //   child: Text('A', style: TextStyle(fontSize: 25)),
                                          // ),
                                          SizedBox(height: 10),
                                          Text(
                                            '${user.name} - ${user.role}' ,
                                            style: TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            user.email ?? 'No Email Registered',
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
                                  );

                                } else {
                                  return DrawerHeader(
                                    padding: EdgeInsets.all(0),
                                    child: Container(
                                      padding: EdgeInsets.all(15),
                                      width: double.infinity,
                                      color: Colors.blue[200],
                                    )
                                  );
                                }
                                
                              }
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
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).pushNamed(ProfileScreen.routeName);
                              },
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