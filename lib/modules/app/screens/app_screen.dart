import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class AppScreen extends StatelessWidget {
  AuthenticationBloc _authBloc;

  @override
  Widget build(BuildContext context) {
    _authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {

        if(state is AppInitial) {
          return SplashScreen();
        } else if(state is AppInformationLoaded){
          
          return BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {

              if(state is AuthenticationUninitialized) {
                return SplashScreen();
              } else if(state is AuthenticationSuccess) {
                return DashboardScreen();
              } else if(state is AuthenticationFailure) {
                return LoginScreen();
              } else {
                return SplashScreen();
              }
            }
          );
        } else {
           return SplashScreen();
        }
        
      }
    );
  }
}