import 'package:flutter/material.dart';
import 'package:inventoryapp/shared/shared.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Colors.white, Colors.blue[100]]
          )
        ),
        child: Center(
          child: Image.asset(
            Assets.logo,
            width: 180,
            height: 180,
          ),
        )
      ),
    );
  }
}