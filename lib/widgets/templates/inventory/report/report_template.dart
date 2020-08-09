import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
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
  bool _isLoading = false;

  List<String> _transactions = ['Incoming', 'Outgoing'];
  String _selectedTransaction;

  _generatePDF(
    String transaction, 
    DateTime startDate,
    DateTime endDate
  ) async {
    setState(() => _isLoading = true);
    List<Incoming> incomings;
    List<Outgoing> outgoings;
    if(transaction == 'Incoming') {
      IncomingRepository incomingRepository = IncomingRepository();
      incomings = await incomingRepository.getAllDataFilteredByDate(startDate, endDate);
    } else {
      OutgoingRepository outgoingRepository = OutgoingRepository();
      outgoings = await outgoingRepository.getAllDataFilteredByDate(startDate, endDate);
    }

    final output = await getApplicationDocumentsDirectory();
    var myTheme = pw.ThemeData.withFont(
      base: pw.Font.ttf(await rootBundle.load("assets/fonts/roboto/Roboto-Regular.ttf")),
      bold: pw.Font.ttf(await rootBundle.load("assets/fonts/roboto/Roboto-Bold.ttf")),
    );
    final pdf = pw.Document(theme: myTheme);
    pdf.addPage(pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) => <pw.Widget>[
        pw.Header(
          level: 0,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: <pw.Widget>[
              pw.Text('$transaction Report', textScaleFactor: 2),
              pw.PdfLogo()
            ])),
        if(transaction == 'Incoming')
        pw.Table.fromTextArray(context: context, data: <List<String>>[
          <String>['Item', 'Supplier', 'Amount', 'Date'],
          ...incomings.map((incoming) => <String>[
              incoming.item.name,
              incoming.supplier.name,
              incoming.amount.toString(),
              DateFormat('dd/MM/yyyy').format(incoming.date)
            ]).toList(),
        ]),

        if(transaction == 'Outgoing')
        pw.Table.fromTextArray(context: context, data: <List<String>>[
          <String>['Item', 'PIC', 'Amount', 'Station', 'Date'],
          ...outgoings.map((outgoing) => <String>[
              outgoing.item.name,
              outgoing.user.name,
              outgoing.amount.toString(),
              outgoing.station.name,
              DateFormat('dd/MM/yyyy').format(outgoing.date)
            ]).toList(),
        ]),
      ]));
    String path = "${output.path}/$transaction - ${DateTime.now().toString()}.pdf";
    print(path);
    final file = File(path);
    await file.writeAsBytes(pdf.save());
    setState(() => _isLoading = false);
    Navigator.of(context).pushNamed(PdfViewerPage.routeName, arguments: path);
  }

  @override
  void initState() {
    super.initState();
    _selectedTransaction = _transactions[0];
    _selectedEndDate = DateTime.now();
    _selectedStartDate = DateTime(_selectedEndDate.year, _selectedEndDate.month, _selectedEndDate.day - 1);
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
                      _generatePDF(_selectedTransaction, _selectedStartDate, _selectedEndDate);
                    }
                  },
                  child: _isLoading
                  ? SizedBox(
                      width: 21,
                      height: 21,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )
                    )
                  : Container(
                      height: 40,
                      child: Center(
                        child: Text(
                          'Generate',
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