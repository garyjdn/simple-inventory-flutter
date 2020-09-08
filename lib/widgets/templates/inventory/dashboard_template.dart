import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;
import 'package:bezier_chart/bezier_chart.dart';
import 'package:responsive_grid/responsive_grid.dart';
import 'package:intl/intl.dart';

class TmpDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Color(0XFF133EAE),
        elevation: 0,
        title: Text('Inventory Dashboard'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, authState) {
        if (authState is AuthenticationSuccess) {
          return Stack(
            fit: StackFit.expand,
            children: <Widget>[

              Align(
                  alignment: Alignment.bottomCenter, child: Wave(height: 150)),
              Container(
                // color: Colors.green,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                child: CustomScrollView(
                  slivers: <Widget>[
                    if (authState.user.role == 'Manager')
                    SliverToBoxAdapter(
                      child: Card(
                        elevation: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Text(
                                    '134',
                                    style: Theme.of(context).textTheme.headline1
                                  ),
                                  Text('Item')
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '35',
                                    style: Theme.of(context).textTheme.headline1
                                  ),
                                  Text('Supplier')
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Text(
                                    '355',
                                    style: Theme.of(context).textTheme.headline1
                                  ),
                                  Text('User')
                                ],
                              )
                            ],
                          )
                        )
                      )
                    ),

                    if (authState.user.role == 'Manager')
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 10, 5, 5),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0XFF5E7DCD),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top:10),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'In - Out Item (Daily)',
                                style: TextStyle(
                                  color: Colors.white,
                                )
                              ),
                            ),
                            Flexible(
                              child: BezierChart(
                                fromDate: DateTime(now.year, now.month, now.day -6),
                                bezierChartScale: BezierChartScale.WEEKLY,
                                toDate: now,
                                selectedDate: now,
                                series: [
                                  BezierLine(
                                    label: "Item In",
                                    onMissingValue: (dateTime) {
                                      if (dateTime.day.isEven) {
                                        return 10.0;
                                      }
                                      return 5.0;
                                    },
                                    data: [
                                      DataPoint<DateTime>(value: 50, xAxis: DateTime(now.year, now.month, now.day -6)),
                                      DataPoint<DateTime>(value: 20, xAxis: DateTime(now.year, now.month, now.day -5)),
                                      DataPoint<DateTime>(value: 30, xAxis: DateTime(now.year, now.month, now.day -4)),
                                      DataPoint<DateTime>(value: 50, xAxis: DateTime(now.year, now.month, now.day -3)),
                                      DataPoint<DateTime>(value: 45, xAxis: DateTime(now.year, now.month, now.day -2)),
                                      DataPoint<DateTime>(value: 60, xAxis: DateTime(now.year, now.month, now.day -1)),
                                      DataPoint<DateTime>(value: 50, xAxis: now),
                                    ],
                                  ),
                                  BezierLine(
                                    label: "Item Out",
                                    onMissingValue: (dateTime) {
                                      if (dateTime.day.isEven) {
                                        return 10.0;
                                      }
                                      return 5.0;
                                    },
                                    data: [
                                      DataPoint<DateTime>(value: 40, xAxis: DateTime(now.year, now.month, now.day -6)),
                                      DataPoint<DateTime>(value: 60, xAxis: DateTime(now.year, now.month, now.day -5)),
                                      DataPoint<DateTime>(value: 36, xAxis: DateTime(now.year, now.month, now.day -4)),
                                      DataPoint<DateTime>(value: 20, xAxis: DateTime(now.year, now.month, now.day -3)),
                                      DataPoint<DateTime>(value: 75, xAxis: DateTime(now.year, now.month, now.day -2)),
                                      DataPoint<DateTime>(value: 40, xAxis: DateTime(now.year, now.month, now.day -1)),
                                      DataPoint<DateTime>(value: 55, xAxis: now),
                                    ],
                                  ),
                                ],
                                config: BezierChartConfig(
                                  verticalIndicatorStrokeWidth: 3.0,
                                  verticalIndicatorColor: Colors.black26,
                                  showVerticalIndicator: true,
                                  verticalIndicatorFixedPosition: false,
                                  backgroundColor: Color(0XFF5E7DCD),
                                  footerHeight: 35.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (authState.user.role == 'Manager')
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0XFF133EAE),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top:10),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'In - Out Item (Monthly)',
                                style: TextStyle(
                                  color: Colors.white,
                                )
                              ),
                            ),
                            Flexible(
                              child: BezierChart(
                                fromDate: DateTime(now.year, now.month-12, now.day),
                                bezierChartScale: BezierChartScale.MONTHLY,
                                toDate: now,
                                selectedDate: now,
                                series: [
                                  BezierLine(
                                    label: "Item In",
                                    onMissingValue: (dateTime) {
                                      if (dateTime.day.isEven) {
                                        return 10.0;
                                      }
                                      return 5.0;
                                    },
                                    data: [
                                      DataPoint<DateTime>(value: 2850, xAxis: DateTime(now.year, now.month-12, now.day)),
                                      DataPoint<DateTime>(value: 7850, xAxis: DateTime(now.year, now.month-11, now.day)),
                                      DataPoint<DateTime>(value: 5850, xAxis: DateTime(now.year, now.month-10, now.day)),
                                      DataPoint<DateTime>(value: 2850, xAxis: DateTime(now.year, now.month-9, now.day)),
                                      DataPoint<DateTime>(value: 1850, xAxis: DateTime(now.year, now.month-8, now.day)),
                                      DataPoint<DateTime>(value: 1850, xAxis: DateTime(now.year, now.month-7, now.day)),
                                      DataPoint<DateTime>(value: 1850, xAxis: DateTime(now.year, now.month-6, now.day)),
                                      DataPoint<DateTime>(value: 2920, xAxis: DateTime(now.year, now.month-5, now.day)),
                                      DataPoint<DateTime>(value: 2330, xAxis: DateTime(now.year, now.month-4, now.day)),
                                      DataPoint<DateTime>(value: 1350, xAxis: DateTime(now.year, now.month-3, now.day)),
                                      DataPoint<DateTime>(value: 1545, xAxis: DateTime(now.year, now.month-2, now.day)),
                                      DataPoint<DateTime>(value: 4260, xAxis: DateTime(now.year, now.month-1, now.day)),
                                      DataPoint<DateTime>(value: 3750, xAxis: now),
                                    ],
                                  ),
                                  BezierLine(
                                    label: "Item Out",
                                    onMissingValue: (dateTime) {
                                      if (dateTime.day.isEven) {
                                        return 10.0;
                                      }
                                      return 5.0;
                                    },
                                    data: [
                                      DataPoint<DateTime>(value: 4850, xAxis: DateTime(now.year, now.month-12, now.day)),
                                      DataPoint<DateTime>(value: 2850, xAxis: DateTime(now.year, now.month-11, now.day)),
                                      DataPoint<DateTime>(value: 6850, xAxis: DateTime(now.year, now.month-10, now.day)),
                                      DataPoint<DateTime>(value: 1850, xAxis: DateTime(now.year, now.month-9, now.day)),
                                      DataPoint<DateTime>(value: 1850, xAxis: DateTime(now.year, now.month-8, now.day)),
                                      DataPoint<DateTime>(value: 1850, xAxis: DateTime(now.year, now.month-7, now.day)),
                                      DataPoint<DateTime>(value: 1250, xAxis: DateTime(now.year, now.month-6, now.day)),
                                      DataPoint<DateTime>(value: 2160, xAxis: DateTime(now.year, now.month-5, now.day)),
                                      DataPoint<DateTime>(value: 2636, xAxis: DateTime(now.year, now.month-4, now.day)),
                                      DataPoint<DateTime>(value: 3720, xAxis: DateTime(now.year, now.month-3, now.day)),
                                      DataPoint<DateTime>(value: 3375, xAxis: DateTime(now.year, now.month-2, now.day)),
                                      DataPoint<DateTime>(value: 1340, xAxis: DateTime(now.year, now.month-1, now.day)),
                                      DataPoint<DateTime>(value: 3255, xAxis: now),
                                    ],
                                  ),
                                ],
                                config: BezierChartConfig(
                                  verticalIndicatorStrokeWidth: 3.0,
                                  verticalIndicatorColor: Colors.black26,
                                  showVerticalIndicator: true,
                                  verticalIndicatorFixedPosition: false,
                                  backgroundColor: Color(0XFF133EAE),
                                  footerHeight: 35.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    if (authState.user.role == 'Manager')
                    SliverToBoxAdapter(
                      child: Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Color(0XFF5E7DCD),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top:10),
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Item Request',
                                style: TextStyle(
                                  color: Colors.white,
                                )
                              ),
                            ),
                            Flexible(
                              child: BezierChart(
                                fromDate: DateTime(now.year, now.month, now.day -6),
                                bezierChartScale: BezierChartScale.WEEKLY,
                                toDate: now,
                                selectedDate: now,
                                series: [
                                  BezierLine(
                                    label: "Request",
                                    onMissingValue: (dateTime) {
                                      if (dateTime.day.isEven) {
                                        return 10.0;
                                      }
                                      return 5.0;
                                    },
                                    data: [
                                      DataPoint<DateTime>(value: 50, xAxis: DateTime(now.year, now.month, now.day -6)),
                                      DataPoint<DateTime>(value: 20, xAxis: DateTime(now.year, now.month, now.day -5)),
                                      DataPoint<DateTime>(value: 30, xAxis: DateTime(now.year, now.month, now.day -4)),
                                      DataPoint<DateTime>(value: 50, xAxis: DateTime(now.year, now.month, now.day -3)),
                                      DataPoint<DateTime>(value: 45, xAxis: DateTime(now.year, now.month, now.day -2)),
                                      DataPoint<DateTime>(value: 60, xAxis: DateTime(now.year, now.month, now.day -1)),
                                      DataPoint<DateTime>(value: 50, xAxis: now),
                                    ],
                                  ),
                                ],
                                config: BezierChartConfig(
                                  verticalIndicatorStrokeWidth: 3.0,
                                  verticalIndicatorColor: Colors.black26,
                                  showVerticalIndicator: true,
                                  verticalIndicatorFixedPosition: false,
                                  backgroundColor: Color(0XFF5E7DCD),
                                  footerHeight: 35.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      delegate: SliverChildListDelegate([
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: InkWell(
                            onTap: () async {
                              if (authState.user.role == 'Admin' 
                              || authState.user.role == 'Operator'
                              || authState.user.role == 'Manager') {
                                Navigator.of(context)
                                    .pushNamed(SupplierMainScreen.routeName);
                              } else {
                                await customDialog.showDialog(
                                    context: context,
                                    builder: (_) => MessageDialog(
                                        message:
                                            'You dont have any permission.'));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Center(
                                          child: Icon(
                                    FontAwesomeIcons.userCheck,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  ))),
                                  SizedBox(height: 12),
                                  Text(
                                    'Supplier',
                                  )
                                ],
                              ),
                            ),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: InkWell(
                            onTap: () async {
                              if (authState.user.role == 'Admin' 
                              || authState.user.role == 'Operator'
                              || authState.user.role == 'Manager') {
                                Navigator.of(context)
                                    .pushNamed(CategoryMainScreen.routeName);
                              } else {
                                await customDialog.showDialog(
                                    context: context,
                                    builder: (_) => MessageDialog(
                                        message:
                                            'You dont have any permission.'));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Center(
                                          child: Icon(
                                    FontAwesomeIcons.palette,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  ))),
                                  SizedBox(height: 10),
                                  Text('Categories')
                                ],
                              ),
                            ),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: InkWell(
                            onTap: () async {
                              if (authState.user.role == 'Admin' 
                              || authState.user.role == 'Operator'
                              || authState.user.role == 'Manager') {
                                Navigator.of(context)
                                    .pushNamed(UnitMainScreen.routeName);
                              } else {
                                await customDialog.showDialog(
                                    context: context,
                                    builder: (_) => MessageDialog(
                                        message:
                                            'You dont have any permission.'));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Center(
                                          child: Icon(
                                    FontAwesomeIcons.unity,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  ))),
                                  SizedBox(height: 10),
                                  Text('Units')
                                ],
                              ),
                            ),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: InkWell(
                            onTap: () async {
                              if (authState.user.role == 'Admin' 
                              || authState.user.role == 'Operator'
                              || authState.user.role == 'Manager') {
                                Navigator.of(context)
                                    .pushNamed(ItemMainScreen.routeName);
                              } else {
                                await customDialog.showDialog(
                                    context: context,
                                    builder: (_) => MessageDialog(
                                        message:
                                            'You dont have any permission.'));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Center(
                                          child: Icon(
                                    FontAwesomeIcons.box,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  ))),
                                  SizedBox(height: 10),
                                  Text('Items')
                                ],
                              ),
                            ),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: InkWell(
                            onTap: () async {
                              if (authState.user.role == 'Operator'
                              || authState.user.role == 'Manager') {
                                Navigator.of(context)
                                    .pushNamed(IncomingMainScreen.routeName);
                              } else {
                                await customDialog.showDialog(
                                    context: context,
                                    builder: (_) => MessageDialog(
                                        message:
                                            'You dont have any permission.'));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Center(
                                          child: Icon(
                                    FontAwesomeIcons.angleDoubleDown,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  ))),
                                  SizedBox(height: 10),
                                  Text('Incoming')
                                ],
                              ),
                            ),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: InkWell(
                            onTap: () async {
                              if (authState.user.role == 'Operator'
                              || authState.user.role == 'Manager') {
                                Navigator.of(context)
                                    .pushNamed(OutgoingMainScreen.routeName);
                              } else {
                                await customDialog.showDialog(
                                    context: context,
                                    builder: (_) => MessageDialog(
                                        message:
                                            'You dont have any permission.'));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Center(
                                          child: Icon(
                                    FontAwesomeIcons.angleDoubleUp,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  ))),
                                  SizedBox(height: 10),
                                  Text('Outgoing')
                                ],
                              ),
                            ),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: InkWell(
                            onTap: () async {
                              Navigator.of(context)
                                  .pushNamed(RequestItemMainScreen.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Center(
                                          child: Icon(
                                    FontAwesomeIcons.handHolding,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  ))),
                                  SizedBox(height: 10),
                                  Text('Request')
                                ],
                              ),
                            ),
                          )),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Center(
                              child: InkWell(
                            onTap: () async {
                              if (authState.user.role == 'Admin' 
                              || authState.user.role == 'Operator'
                              || authState.user.role == 'Manager') {
                                Navigator.of(context)
                                    .pushNamed(ReportScreen.routeName);
                              } else {
                                await customDialog.showDialog(
                                    context: context,
                                    builder: (_) => MessageDialog(
                                        message:
                                            'You dont have any permission.'));
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.white, width: 1.5),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      child: Center(
                                          child: Icon(
                                    FontAwesomeIcons.solidFilePdf,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  ))),
                                  SizedBox(height: 10),
                                  Text('Report')
                                ],
                              ),
                            ),
                          )),
                        )
                      ]),
                    ),
                    
                    if (authState.user.role == 'Manager') 
                    SliverToBoxAdapter(
                      child: SizedBox(height: 5)
                    ),

                    if (authState.user.role == 'Manager')
                    SliverToBoxAdapter(
                      child: Card(
                        elevation: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'New Item Request',
                                style: Theme.of(context).textTheme.headline4
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0XFF133EAE),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5), 
                                    topRight: Radius.circular(5)
                                  ),
                                ),
                                child: ResponsiveGridRow(
                                  children: [
                                    ResponsiveGridCol(
                                      xs: 4,
                                      child: Padding(
                                        padding:EdgeInsets.all(10),
                                        child: Text('Date', style: TextStyle(color: Colors.white, fontSize: 12),)
                                      )
                                    ),
                                    ResponsiveGridCol(
                                      xs: 5,
                                      child: Padding(
                                        padding:EdgeInsets.all(10),
                                        child: Text('Item', style: TextStyle(color: Colors.white, fontSize: 12),)
                                      )
                                    ),
                                    ResponsiveGridCol(
                                      xs: 3,
                                      child: Padding(
                                        padding:EdgeInsets.all(10),
                                        child: Text('Amount', style: TextStyle(color: Colors.white, fontSize: 12),)
                                      )
                                    )
                                  ],
                                )
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffdddddd)
                                  )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 4,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(DateFormat('yyyy-MM-dd').format(now)),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 5,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('Pen'),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 3,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('5')
                                          )
                                        ),
                                      ],
                                    ),
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 4,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(DateFormat('yyyy-MM-dd').format(now)),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 5,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('Papper 500gr'),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 3,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('55')
                                          )
                                        ),
                                      ],
                                    ),
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 4,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(DateFormat('yyyy-MM-dd').format(now)),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 5,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('Duplex'),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 3,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('80')
                                          )
                                        ),
                                      ],
                                    ),
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 4,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(DateFormat('yyyy-MM-dd').format(now)),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 5,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('Plywood')
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 3,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('50')
                                          )
                                        ),
                                      ],
                                    ),
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 4,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(DateFormat('yyyy-MM-dd').format(now)),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 5,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('Box 5KG'),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 3,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('40')
                                          )
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        )
                      )
                    ),

                    if (authState.user.role == 'Manager')
                    SliverToBoxAdapter(
                      child: SizedBox(height: 5)
                    ),

                    if (authState.user.role == 'Manager')
                    SliverToBoxAdapter(
                      child: Card(
                        elevation: 0,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Low Stock Alert',
                                style: Theme.of(context).textTheme.headline4
                              ),
                              SizedBox(height: 5),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(0XFF133EAE),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5), 
                                    topRight: Radius.circular(5)
                                  ),
                                ),
                                child: ResponsiveGridRow(
                                  children: [
                                    ResponsiveGridCol(
                                      xs: 6,
                                      child: Padding(
                                        padding:EdgeInsets.all(10),
                                        child: Text('Item', style: TextStyle(color: Colors.white, fontSize: 12),)
                                      )
                                    ),
                                    ResponsiveGridCol(
                                      xs: 6,
                                      child: Padding(
                                        padding:EdgeInsets.all(10),
                                        child: Text('Amount', style: TextStyle(color: Colors.white, fontSize: 12),)
                                      )
                                    )
                                  ],
                                )
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffdddddd)
                                  )
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(
                                              'Pen', 
                                              style: TextStyle(
                                                fontSize: 12
                                              )
                                            ),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('5')
                                          )
                                        ),
                                      ],
                                    ),
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(
                                              'Papper 500gr', 
                                              style: TextStyle(
                                                fontSize: 12
                                              )
                                            ),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('11')
                                          )
                                        ),
                                      ],
                                    ),
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(
                                              'Eraser', 
                                              style: TextStyle(
                                                fontSize: 12
                                              )
                                            ),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('1')
                                          )
                                        ),
                                      ],
                                    ),
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(
                                              'Scissor', 
                                              style: TextStyle(
                                                fontSize: 12
                                              )
                                            ),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('7')
                                          )
                                        ),
                                      ],
                                    ),
                                    ResponsiveGridRow(
                                      children: [
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text(
                                              'Stabilo', 
                                              style: TextStyle(
                                                fontSize: 12
                                              )
                                            ),
                                          )
                                        ),
                                        ResponsiveGridCol(
                                          xs: 6,
                                          child: Padding(
                                            padding:EdgeInsets.all(10),
                                            child: Text('4')
                                          )
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        )
                      )
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(height: 150),
                    )
                  ],
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
