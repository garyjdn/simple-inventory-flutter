import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';

class RequestModal extends StatefulWidget {
  final User user;
  final List<Station> stations;
  final RequestItemBloc requestItemBloc;

  RequestModal({
    @required this.user,
    @required this.stations,
    @required this.requestItemBloc,
  });

  @override
  _RequestModalState createState() => _RequestModalState();
}

class _RequestModalState extends State<RequestModal> {

  Station _selectedStation;
  RequestItemBloc _requestItemBloc;

  @override
  void initState() {
    super.initState();
    _requestItemBloc = widget.requestItemBloc;
    _selectedStation = widget.stations[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Create New Request',
              style: Theme.of(context).textTheme.headline4
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<Station>(
              value: _selectedStation ?? widget.stations[0],
              items: widget.stations.map((Station value) {
                return DropdownMenuItem<Station>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Station',
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
              onChanged: (value) => setState(() => _selectedStation = value),
              validator: (value) {
                if (value == null) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  elevation: 0,
                  onPressed: () {
                    _requestItemBloc.add(AddRequestItemButtonPressed(
                      user: widget.user,
                      station: _selectedStation
                    ));
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Submit')
                )
              ],
            )
          ],
        )
      ),
    );
  }
}