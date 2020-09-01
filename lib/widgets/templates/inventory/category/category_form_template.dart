import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpCategoryForm extends StatefulWidget {
  final String title;
  final String action;
  final Category category;

  TmpCategoryForm({@required this.title, @required this.action, this.category})
      : assert(title != null && title.isNotEmpty),
        assert(action != null && action.isNotEmpty);

  @override
  _TmpCategoryFormState createState() => _TmpCategoryFormState();
}

class _TmpCategoryFormState extends State<TmpCategoryForm> {
  final _formKey = GlobalKey<FormState>();
  CategoryFormBloc _categoryFormBloc;
  TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    _categoryFormBloc = BlocProvider.of<CategoryFormBloc>(context);

    _nameCtrl = TextEditingController();

    if (widget.category != null) {
      _nameCtrl.text = widget.category.name;
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
          body: BlocListener<CategoryFormBloc, CategoryFormState>(
            listener: (context, state) async {
              if (state is CategoryFormSubmitSuccess) {
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
                                        color: Color(0XFF133EAE), width: 1),
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
                    BlocBuilder<CategoryFormBloc, CategoryFormState>(
                        builder: (context, state) {
                      if (state is CategoryFormSubmitInProgress) {
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
                                    _categoryFormBloc.add(
                                        AddCategoryButtonPressed(
                                            name: _nameCtrl.text));
                                  } else if (widget.action == 'edit') {
                                    assert(widget.category != null);
                                    Category category = widget.category
                                      ..name = _nameCtrl.text;
                                    _categoryFormBloc.add(
                                        EditCategoryButtonPressed(
                                            category: category));
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
