import 'package:flutter/material.dart';
import 'modules/modules.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SupplierMainScreen.routeName: (ctx) => SupplierMainScreen(),
  SupplierFormScreen.routeName: (ctx) => SupplierFormScreen(),
  UserMainScreen.routeName: (ctx) => UserMainScreen(),
  UserFormScreen.routeName: (ctx) => UserFormScreen(),
};