import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;

class TmpUserMain extends StatelessWidget {
  UserBloc _userBloc;

  Future deleteDialog(BuildContext ctx, User user) async {
    return await showDialog(
      context: ctx,
      builder: (BuildContext context) => CustomDialog(
        title: 'Delete User?',
        content: Text('You will permanently remove this item'),
        primaryButton: PrimaryButton(
          onPressed: () {
            Navigator.of(context).pop();
            _userBloc.add(DeleteUserButtonPressed(user: user));
          },
          text: 'Delete'
        ),
        secondaryButton: SecondaryButton(
          onPressed: () => Navigator.of(context).pop(),
          text: 'Cancel'
        ),
      )
    );
  }
  

  @override
  Widget build(BuildContext context) {
    _userBloc = BlocProvider.of<UserBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        // automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('User'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.add),
        onPressed: () async {
          final fetch = await Navigator
            .of(context)
            .pushNamed(
              UserFormScreen.routeName, 
              arguments: UserFormScreenArguments(
                title: 'Add User', 
                action: 'create'));

          if(fetch != null && fetch)
            _userBloc.add(LoadUserStarted());
        },
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) async {
          if(state is UserDeleteSuccess) {
            await customDialog.showDialog(
              context: context,
              builder: (_) => MessageDialog(
                message: state.message
              )
            );
            _userBloc.add(LoadUserStarted());
          }
        },
        buildWhen: (prevState, state) {
          if(state is UserLoadStarted
          || state is UserLoadSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if(state is UserLoadStarted) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is UserLoadSuccess) {
            return ListView(
              padding: EdgeInsets.all(15.0),
              children: state.users.map((user) => Card(
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.user,
                    color: Color(0xff5a5a5a),
                  ),
                  title: Text(
                    user.name,
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                  subtitle: Text(
                    user.role,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => deleteDialog(context, user),
                        icon: Icon(FontAwesomeIcons.trash),
                        iconSize: 18,
                      ),
                      // SizedBox(width: 8),
                      IconButton(
                        onPressed: () async {
                          final fetch = await Navigator
                            .of(context)
                            .pushNamed(
                              UserFormScreen.routeName, 
                              arguments: UserFormScreenArguments(
                                title: 'Edit User', 
                                action: 'edit',
                                user: user));
                          
                          if(fetch != null && fetch)
                          _userBloc.add(LoadUserStarted());
                        },
                        icon: Icon(FontAwesomeIcons.solidEdit),
                        iconSize: 18,
                      )
                    ],
                  ),
                ),
              )).toList()
            );
          } else {
            return Container();
          }
          
        }
      )
    );
  }
}