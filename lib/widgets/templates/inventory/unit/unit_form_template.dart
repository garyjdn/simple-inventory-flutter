import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpUnitForm extends StatefulWidget {
  final String title;
  final String action;
  final Unit unit;

  TmpUnitForm({@required this.title, @required this.action, this.unit})
      : assert(title != null && title.isNotEmpty),
        assert(action != null && action.isNotEmpty);

  @override
  _TmpUnitFormState createState() => _TmpUnitFormState();
}

class _TmpUnitFormState extends State<TmpUnitForm> {
  final _formKey = GlobalKey<FormState>();
  UnitFormBloc _unitFormBloc;
  TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    _unitFormBloc = BlocProvider.of<UnitFormBloc>(context);

    _nameCtrl = TextEditingController();

    if (widget.unit != null) {
      _nameCtrl.text = widget.unit.name;
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
            backgroundColor: Colors.blueAccent[700],
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text(widget.title),
            centerTitle: true,
          ),
          body: BlocListener<UnitFormBloc, UnitFormState>(
            listener: (context, state) async {
              if (state is UnitFormSubmitSuccess) {
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
                                        color: Colors.blue[600], width: 1),
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
                    BlocBuilder<UnitFormBloc, UnitFormState>(
                        builder: (context, state) {
                      if (state is UnitFormSubmitInProgress) {
                        return Container(
                            height: 55,
                            width: double.infinity,
                            child: RaisedButton(
                                onPressed: () {},
                                elevation: 0,
                                color: Colors.blueAccent[700],
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
                                    _unitFormBloc.add(AddUnitButtonPressed(
                                        name: _nameCtrl.text));
                                  } else if (widget.action == 'edit') {
                                    assert(widget.unit != null);
                                    Unit unit = widget.unit
                                      ..name = _nameCtrl.text;
                                    _unitFormBloc
                                        .add(EditUnitButtonPressed(unit: unit));
                                  }
                                }
                              },
                              elevation: 0,
                              color: Colors.blueAccent[700],
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
