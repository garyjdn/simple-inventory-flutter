import 'package:flutter/material.dart';
import 'package:inventoryapp/modules/inventory/screens/request_item/request_item.dart';
import 'package:inventoryapp/modules/inventory/screens/request_item_detail/request_item_detail_main_screen.dart';
import 'package:inventoryapp/modules/inventory/screens/security/security.dart';
import 'modules/modules.dart';

Map<String, Widget Function(BuildContext)> routes = {
  CategoryMainScreen.routeName: (ctx) => CategoryMainScreen(),
  CategoryFormScreen.routeName: (ctx) => CategoryFormScreen(),
  IncomingMainScreen.routeName: (ctx) => IncomingMainScreen(),
  IncomingFormScreen.routeName: (ctx) => IncomingFormScreen(),
  ItemMainScreen.routeName: (ctx) => ItemMainScreen(),
  ItemFormScreen.routeName: (ctx) => ItemFormScreen(),
  OutgoingMainScreen.routeName: (ctx) => OutgoingMainScreen(),
  OutgoingFormScreen.routeName: (ctx) => OutgoingFormScreen(),
  ReportScreen.routeName: (ctx) => ReportScreen(),
  PdfViewerPage.routeName: (ctx) => PdfViewerPage(),
  ProfileScreen.routeName: (ctx) => ProfileScreen(),
  ChangePasswordFormScreen.routeName: (ctx) => ChangePasswordFormScreen(),
  RequestItemMainScreen.routeName: (ctx) => RequestItemMainScreen(),
  RequestItemDetailMainScreen.routeName: (ctx) => RequestItemDetailMainScreen(),
  StationMainScreen.routeName: (ctx) => StationMainScreen(),
  StationFormScreen.routeName: (ctx) => StationFormScreen(),
  SupplierMainScreen.routeName: (ctx) => SupplierMainScreen(),
  SupplierFormScreen.routeName: (ctx) => SupplierFormScreen(),
  UnitMainScreen.routeName: (ctx) => UnitMainScreen(),
  UnitFormScreen.routeName: (ctx) => UnitFormScreen(),
  UserMainScreen.routeName: (ctx) => UserMainScreen(),
  UserFormScreen.routeName: (ctx) => UserFormScreen(),
};