import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart'
    as customDialog;
import 'package:inventoryapp/widgets/widgets.dart';

class TmpProfile extends StatefulWidget {
  @override
  _TmpProfileState createState() => _TmpProfileState();
}

class _TmpProfileState extends State<TmpProfile> {
  TextEditingController _emailCtrl = TextEditingController();
  TextEditingController _nameCtrl = TextEditingController();
  ProfileBloc _profileBloc;

  final _formKey = GlobalKey<FormState>();
  File _image;
  String imageLink;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
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
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.blue[50],
          appBar: AppBar(
            backgroundColor: Color(0XFF133EAE),
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back_ios),
            ),
            title: Text('My Profile'),
            centerTitle: true,
          ),
          body: BlocConsumer<ProfileBloc, ProfileState>(
              listener: (context, state) async {
            if (state is ProfileFormSubmitSuccess) {
              await customDialog.showDialog(
                  context: context,
                  builder: (_) => MessageDialog(message: state.message));
              Navigator.of(context).pop(true);
            }
          }, buildWhen: (prevState, state) {
            if (state is ProfileLoadStarted || state is ProfileLoadSuccess) {
              return true;
            }
            return false;
          }, builder: (context, state) {
            if (state is ProfileLoadSuccess) {
              _emailCtrl.text = state.user.email;
              _nameCtrl.text = state.user.name;
              imageLink = state.user.image.isNotEmpty ? state.user.image : null;
              return LayoutBuilder(builder:
                  (BuildContext context, BoxConstraints viewportConstraints) {
                return SingleChildScrollView(
                    child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: () => getImage(),
                            child: CircleAvatar(
                              child: ClipOval(
                                  child: _image != null
                                      ? Image.file(_image, fit: BoxFit.cover)
                                      : imageLink != null
                                          ? Image.network(imageLink)
                                          : Icon(Icons.person, size: 70)),
                              radius: 70,
                            ),
                          ),
                          SizedBox(height: 40),
                          Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(' UID'),
                                  SizedBox(height: 5),
                                  Text(' Email'),
                                ],
                              ),
                              SizedBox(width: 5),
                              Column(
                                children: <Widget>[Text(':'), Text(':')],
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(state.user.id),
                                  SizedBox(height: 5),
                                  Text(state.user.email),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 20),
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
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                              elevation: 0,
                              color: Color(0XFF133EAE),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  User user = state.user;
                                  user.name = _nameCtrl.text;
                                  user.email = _emailCtrl.text;
                                  _profileBloc.add(EditProfileButtonPressed(
                                      user: user, image: _image));
                                }
                              },
                              child: Container(
                                height: 40,
                                child: BlocBuilder<ProfileBloc, ProfileState>(
                                    builder: (context, state) {
                                  if (state is ProfileFormSubmitInProgress) {
                                    return Center(
                                        child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        valueColor:
                                            new AlwaysStoppedAnimation<Color>(
                                                Colors.white),
                                      ),
                                    ));
                                  }
                                  return Center(
                                      child: Text('Update',
                                          style:
                                              TextStyle(color: Colors.white)));
                                }),
                              ))
                        ],
                      ),
                    ),
                  ),
                ));
              });
            } else if (state is ProfileLoadStarted) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Container();
            }
          })),
    );
  }
}
