import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

class TmpReport extends StatefulWidget {
  @override
  _TmpReportState createState() => _TmpReportState();
}

class _TmpReportState extends State<TmpReport> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedStartDate;
  DateTime _selectedEndDate;

  List<String> _transactions = ['Incoming', 'Outgoing'];
  String _selectedTransaction;

  _generatePDF(String transaction) async {
    if(transaction == 'Incoming') {

    } else {

    }

    final output = await getApplicationDocumentsDirectory();
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load("assets/fonts/roboto/Roboto-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("assets/fonts/roboto/Roboto-Bold.ttf")),
    );
    final pdf = pw.Document(theme: myTheme);
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Center(
          child: pw.Text("Hello World"),
        ); // Center
      }));
      
    final file = File("${output.path}/$transaction - ${DateTime.now().toString()}.pdf");
    await file.writeAsBytes(pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.blue[50],
        appBar: AppBar(
          backgroundColor: Colors.blue[300],
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: Text('Report'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: DateTimeField(
                        decoration: InputDecoration(
                          labelText: 'Date Start',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue[600],
                              width: 1
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue[600],
                              width: 1
                            ),
                          )
                        ),
                        initialValue: _selectedStartDate ?? DateTime.now(),
                        format: DateFormat("yyyy-MM-dd"),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        onChanged: (DateTime dt) => _selectedStartDate = dt,
                        validator: (value) {
                          if (value == null) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: DateTimeField(
                        decoration: InputDecoration(
                          labelText: 'Date End',
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue[600],
                              width: 1
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.blue[600],
                              width: 1
                            ),
                          )
                        ),
                        initialValue: _selectedEndDate ?? DateTime.now(),
                        format: DateFormat("yyyy-MM-dd"),
                        onShowPicker: (context, currentValue) {
                          return showDatePicker(
                              context: context,
                              firstDate: DateTime(1900),
                              initialDate: currentValue ?? DateTime.now(),
                              lastDate: DateTime(2100));
                        },
                        onChanged: (DateTime dt) => _selectedEndDate = dt,
                        validator: (value) {
                          if (value == null) {
                            return 'This field is required';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedTransaction ?? _transactions[0],
                  items: _transactions.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    labelText: 'Transaction',
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue[600],
                        width: 1
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue[600],
                        width: 1
                      ),
                    )
                  ),
                  onChanged: (value) => setState(() => _selectedTransaction = value),
                  validator: (value) {
                    if (value == null) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                RaisedButton(
                  elevation: 0,
                  color: Colors.blue[300],
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _generatePDF(_selectedTransaction);
                      // User user = state.user;
                      // user.name = _nameCtrl.text;
                      // user.email = _emailCtrl.text;
                      // _profileBloc.add(EditProfileButtonPressed(
                      //   user: user,
                      //   image: _image
                      // ));
                    }
                  },
                  child: Container(
                    height: 40,
                    child: Center(
                      child: Text(
                        'Create',
                        style: TextStyle(
                          color: Colors.white
                        )
                      )
                    ),
                  )
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}