import 'package:flutter/material.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String message;

  MessageDialog({
    this.title,
    this.message
  }):
    assert(message != null && message.isNotEmpty);

  @override
  Widget build(BuildContext context) {
    return customDialog.AlertDialog(
      paddingHorizontal: 10.0,
      paddingVertical: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      contentPadding: EdgeInsets.all(20.0),
      titlePadding: EdgeInsets.symmetric(vertical: 5.0),
      title: title != null && title.isNotEmpty
        ? Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(title ?? ''),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.close,
                        size: 20.0,
                      ),
                    )
                  ],
                ),
              ),
              Divider()
            ],
          )
        : null,
      content: Container(
        child: Text(message)
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            'Close',
            style: TextStyle(color: Colors.black),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}