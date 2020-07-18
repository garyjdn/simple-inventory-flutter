import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  AppTheme._();

  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.purple[900],
    scaffoldBackgroundColor: AppColors.background,
    brightness: Brightness.light,
    fontFamily: 'Roboto',
    textTheme: lightTextTheme,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    // buttonTheme: ButtonThemeData(
    //   buttonColor: AppColors.primary,
      // textTheme: ButtonTextTheme.values() //color of the text in the button "OK/CANCEL"
    // ),
  );

  static final TextTheme lightTextTheme = TextTheme(
    headline1: _headline1,
    headline2: _headline2,
    headline3: _headline3,
    headline4: _headline4,
    headline5: _headline5,
    headline6: _headline6,
    bodyText1: _strong,
    bodyText2: _body,
    button: button
  );

  static final TextStyle _headline1 = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.typography,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle _headline2 = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.typography,
    fontSize: 18,
    fontWeight: FontWeight.w600
  );

  static final TextStyle _headline3 = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.heading,
    fontSize: 16,
    fontWeight: FontWeight.w600
  );

  static final TextStyle _headline4 = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.typography,
    fontSize: 14,
    fontWeight: FontWeight.w600
  );

  static final TextStyle _headline5 = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.typography,
    fontSize: 16,
    fontWeight: FontWeight.normal
  );

  static final TextStyle _headline6 = TextStyle(
    fontFamily: 'Poppins',
    color: AppColors.typography,
    fontSize: 16,
    fontWeight: FontWeight.normal
  );

  static final TextStyle _body = TextStyle(
    fontFamily: 'Roboto',
    color: AppColors.typography,
    fontSize: 12,
    fontWeight: FontWeight.normal
  );

  static final TextStyle button = TextStyle(
    fontFamily: 'Roboto',
    fontSize: 16,
    color: Colors.white
  );


  static final TextStyle _strong = _body.copyWith(
    fontWeight: FontWeight.bold, 
    color: AppColors.heading
  );
  
  static final TextStyle weak = _body.copyWith(color: Color(0xff888888));

}