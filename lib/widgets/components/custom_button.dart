import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final bool isLoading;
  final TextStyle textStyle;
  final Function onPressed;

  PrimaryButton(
      {
      // @required this.context,
      this.text = 'Ok',
      this.isLoading = false,
      textStyle,
      this.onPressed})
      : assert(text != null && text.isNotEmpty),
        this.textStyle = textStyle ??
            TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? () {} : onPressed,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
              color: Color(0XFF133EAE),
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Color(0XFF133EAE))),
          child: Center(
              child: isLoading
                  ? SizedBox(
                      width: 21,
                      height: 21,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ))
                  : Text(text, style: textStyle))),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String text;
  final TextStyle textStyle;
  final Function onPressed;

  SecondaryButton(
      {
      // @required this.context,
      this.text = 'Cancel',
      textStyle,
      this.onPressed})
      : assert(text != null && text.isNotEmpty),
        this.textStyle = textStyle ??
            TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0XFF133EAE),
            );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(color: Color(0XFF133EAE))),
          child: Center(child: Text(text, style: textStyle))),
    );
  }
}
