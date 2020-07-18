import 'package:flutter/material.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/shared/shared.dart';
import 'routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventory App',
      theme: AppTheme.lightTheme,
      home: AppScreen(),
      routes: routes,
    );
  }
}
