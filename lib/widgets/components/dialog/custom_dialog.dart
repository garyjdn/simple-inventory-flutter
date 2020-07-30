import 'package:flutter/material.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/dialog/custom_base_dialog.dart' as customDialog;


enum ActionAlignment {
  VERTICAL,
  HORIZONTAL
}

class CustomDialog extends StatefulWidget {
  final String title;
  final Widget content;
  final CrossAxisAlignment titleAlign;
  final PrimaryButton primaryButton;
  final SecondaryButton secondaryButton;
  final ActionAlignment actionAlignment;
  final bool closeIcon;

  CustomDialog({
    this.title,
    @required this.content,
    this.titleAlign = CrossAxisAlignment.center,
    this.primaryButton,
    this.secondaryButton,
    this.actionAlignment = ActionAlignment.HORIZONTAL,
    this.closeIcon = true,
  }):
    assert(content != null);

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {

  Widget action;

  @override
  Widget build(BuildContext context) {
    return customDialog.AlertDialog(
      paddingHorizontal: 15.0,
      // paddingVertical: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
      contentPadding: EdgeInsets.fromLTRB(25.0, 0, 25.0, 45.0),
      titlePadding: EdgeInsets.all(10.0),
      title: widget.closeIcon
      ? Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.close,
              size: 22.0,
            ),
          ),
        )
      : null,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: widget.titleAlign ?? CrossAxisAlignment.center,
        children: <Widget>[
          if(widget.title != null && widget.title.isNotEmpty)
          Container(
            child: Text(
              widget.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600
              )
            ),
            margin: EdgeInsets.only(bottom: 30.0)
          ),

          widget.content,
          SizedBox(height: 30),

          if((widget.primaryButton != null 
          || widget.secondaryButton != null)
          && widget.actionAlignment == ActionAlignment.HORIZONTAL)
          Row(
            children: <Widget>[
              if(widget.secondaryButton != null)
              Flexible(child: widget.secondaryButton,),
              if(widget.primaryButton != null && widget.secondaryButton != null)
              SizedBox(width: 10),
              if(widget.primaryButton != null)
              Flexible(child: widget.primaryButton),
            ],
          ),

          if((widget.primaryButton != null 
          || widget.secondaryButton != null)
          && widget.actionAlignment == ActionAlignment.VERTICAL)
          Column(
            children: <Widget>[
              if(widget.primaryButton != null)
              widget.primaryButton,
              if(widget.primaryButton != null && widget.secondaryButton != null)
              SizedBox(height: 12),
              if(widget.secondaryButton != null)
              widget.secondaryButton
            ],
          ),

          Container(width: 1000, height:1, color: Colors.transparent)
        ],
      )
    );
  }
}