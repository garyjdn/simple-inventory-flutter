import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class TmpDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Inventory Dashboard'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body:  Stack(
        fit: StackFit.expand,
        children: <Widget>[

          Align(
            alignment: Alignment.bottomCenter,
            child: Wave(height: 150)
          ),
          Container(
            // color: Colors.green,
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.all(15),
            child: CustomScrollView(
              slivers: <Widget>[
                SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  delegate: SliverChildListDelegate([
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed(SupplierMainScreen.routeName),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Icon(
                                      FontAwesomeIcons.userCheck,
                                    color: Color(0xff5a5a5a),
                                      size: 32,
                                    )
                                  )
                                ),
                                SizedBox(height: 12),
                                Text(
                                  'Supplier',
                                )
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed(CategoryMainScreen.routeName),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Icon(
                                      FontAwesomeIcons.palette,
                                      color: Color(0xff5a5a5a),
                                      size: 32,
                                    )
                                  )
                                ),
                                SizedBox(height: 10),
                                Text('Categories')
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed(UnitMainScreen.routeName),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Icon(
                                      FontAwesomeIcons.unity,
                                      color: Color(0xff5a5a5a),
                                      size: 32,
                                    )
                                  )
                                ),
                                SizedBox(height: 10),
                                Text('Units')
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed(ItemMainScreen.routeName),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Icon(
                                      FontAwesomeIcons.box,
                                      color: Color(0xff5a5a5a),
                                      size: 32,
                                    )
                                  )
                                ),
                                SizedBox(height: 10),
                                Text('Items')
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: InkWell(
                          onTap: () => Navigator.of(context).pushNamed(IncomingMainScreen.routeName),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.white, width: 1.5),
                              borderRadius: BorderRadius.circular(8)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: Icon(
                                      FontAwesomeIcons.angleDoubleDown,
                                      color: Color(0xff5a5a5a),
                                      size: 32,
                                    )
                                  )
                                ),
                                SizedBox(height: 10),
                                Text('Incoming')
                              ],
                            ),
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.angleDoubleUp,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  )
                                )
                              ),
                              SizedBox(height: 10),
                              Text('Outgoing')
                            ],
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.exclamationCircle,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  )
                                )
                              ),
                              SizedBox(height: 10),
                              Text('Status')
                            ],
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.handHolding,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  )
                                )
                              ),
                              SizedBox(height: 10),
                              Text('Request')
                            ],
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Icon(
                                    FontAwesomeIcons.solidFilePdf,
                                    color: Color(0xff5a5a5a),
                                    size: 32,
                                  )
                                )
                              ),
                              SizedBox(height: 10),
                              Text('Report')
                            ],
                          ),
                        )
                      ),
                    )
                  ]),
                ),
              ],
            ),
          ),
        ],
      ),
      
    );
  }
}