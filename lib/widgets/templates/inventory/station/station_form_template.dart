import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpStationForm extends StatefulWidget {
  final String title;
  final String action;
  final Station station;

  TmpStationForm({@required this.title, @required this.action, this.station})
      : assert(title != null && title.isNotEmpty),
        assert(action != null && action.isNotEmpty);

  @override
  _TmpStationFormState createState() => _TmpStationFormState();
}

class _TmpStationFormState extends State<TmpStationForm> {
  final _formKey = GlobalKey<FormState>();
  StationFormBloc _stationFormBloc;
  TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    _stationFormBloc = BlocProvider.of<StationFormBloc>(context);

    _nameCtrl = TextEditingController();

    if (widget.station != null) {
      _nameCtrl.text = widget.station.name;
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;

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
            backgroundColor: Color(0XFF133EAE),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: BlocListener<StationFormBloc, StationFormState>(
            listener: (context, state) async {
              if (state is StationFormSubmitSuccess) {
                await customDialog.showDialog(
                    context: context,
                    builder: (_) => MessageDialog(message: state.message));
                Navigator.of(context).pop(true);
              }
            },
            child: Container(
              height: deviceSize.height,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: 10),
                            TextFormField(
                              controller: _nameCtrl,
                              decoration: InputDecoration(
                                  labelText: 'Name',
                                  filled: true,
                                  fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color(0XFF133EAE), width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue[600], width: 1),
                                  )),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    BlocBuilder<StationFormBloc, StationFormState>(
                        builder: (context, state) {
                      if (state is StationFormSubmitInProgress) {
                        return Container(
                            height: 55,
                            width: double.infinity,
                            child: RaisedButton(
                                onPressed: () {},
                                elevation: 0,
                                color: Color(0XFF133EAE),
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    valueColor:
                                        new AlwaysStoppedAnimation<Color>(
                                            Colors.white),
                                  ),
                                )));
                      }
                      return Container(
                          height: 55,
                          width: double.infinity,
                          child: RaisedButton(
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  if (widget.action == 'create') {
                                    _stationFormBloc.add(
                                        AddStationButtonPressed(
                                            name: _nameCtrl.text));
                                  } else if (widget.action == 'edit') {
                                    assert(widget.station != null);
                                    Station station = widget.station
                                      ..name = _nameCtrl.text;
                                    _stationFormBloc.add(
                                        EditStationButtonPressed(
                                            station: station));
                                  }
                                }
                              },
                              elevation: 0,
                              color: Color(0XFF133EAE),
                              child: widget.action == 'create'
                                  ? Text('Create',
                                      style: TextStyle(color: Colors.white))
                                  : Text('Update',
                                      style: TextStyle(color: Colors.white))));
                    })
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
