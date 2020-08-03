import 'package:flutter/material.dart';
import 'modules/modules.dart';

Map<String, Widget Function(BuildContext)> routes = {
  CategoryMainScreen.routeName: (ctx) => CategoryMainScreen(),
  CategoryFormScreen.routeName: (ctx) => CategoryFormScreen(),
  StationMainScreen.routeName: (ctx) => StationMainScreen(),
  StationFormScreen.routeName: (ctx) => StationFormScreen(),
  SupplierMainScreen.routeName: (ctx) => SupplierMainScreen(),
  SupplierFormScreen.routeName: (ctx) => SupplierFormScreen(),
  UnitMainScreen.routeName: (ctx) => UnitMainScreen(),
  UnitFormScreen.routeName: (ctx) => UnitFormScreen(),
  UserMainScreen.routeName: (ctx) => UserMainScreen(),
  UserFormScreen.routeName: (ctx) => UserFormScreen(),
};