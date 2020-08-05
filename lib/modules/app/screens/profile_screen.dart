import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        if(state is AuthenticationSuccess) {
          return BlocProvider<ProfileBloc>(
            create: (BuildContext context) => ProfileBloc()..add(LoadProfileStarted(uid: state.user.id)),
            child: TmpProfile()
          );
        } else {
          return Scaffold(
            backgroundColor: Colors.blue[50],
            appBar: AppBar(
              backgroundColor: Colors.blue[300],
              leading: IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icon(Icons.arrow_back_ios),
              ),
              title: Text('Profile'),
              centerTitle: true,
            ),
            body: Center(
              child: Text('You are not authenticated'),
            )
          );
        }
      }
    );
  }
}
