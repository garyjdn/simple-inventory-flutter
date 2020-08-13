import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/shared/shared.dart';
import 'package:permission_handler/permission_handler.dart';
import 'routes.dart';

void main() async {
  runApp(MyApp());

  Map<Permission, PermissionStatus> permissions =
      await [Permission.storage].request();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppBloc>(
          create: (BuildContext context) => AppBloc()..add(AppStarted()),
        ),
        BlocProvider<AuthenticationBloc>(
          create: (BuildContext context) =>
              AuthenticationBloc()..add(AuthStarted()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Inventory App',
        theme: AppTheme.lightTheme,
        home: AppScreen(),
        routes: routes,
      ),
    );
  }
}
