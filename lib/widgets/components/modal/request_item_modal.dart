import 'package:flutter/material.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';

class RequestItemModal extends StatefulWidget {
  final String action;
  final List<Item> items;
  final Item selectedItem;
  final RequestItem requestItem;
  final RequestItemDetail requestItemDetail;
  final RequestItemDetailBloc requestItemDetailBloc;

  RequestItemModal({
    @required this.action,
    @required this.items,
    @required this.requestItem,
    @required this.requestItemDetailBloc,
    this.requestItemDetail,
    this.selectedItem,
  }) {
    if(action == 'Edit') {
      assert(requestItemDetail != null);
    }
  }

  @override
  _RequestItemModalState createState() => _RequestItemModalState();
}

class _RequestItemModalState extends State<RequestItemModal> {

  Item _selectedItem;
  RequestItemDetailBloc _requestItemDetailBloc;
  TextEditingController _amountCtrl;

  @override
  void initState() {
    super.initState();
    _amountCtrl = TextEditingController();
    _requestItemDetailBloc = widget.requestItemDetailBloc;
    _selectedItem = widget.items[0];

    if(widget.action == 'Edit') {
      _selectedItem = widget.requestItemDetail.item;
      _amountCtrl.text = widget.requestItemDetail.amount.toString();
    }
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
              '${widget.action} Request Item',
              style: Theme.of(context).textTheme.headline4
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<Item>(
              value: _selectedItem ?? widget.items[0],
              items: widget.items.map((Item value) {
                return DropdownMenuItem<Item>(
                  value: value,
                  child: Text(value.name),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Item',
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
              onChanged: (value) => setState(() => _selectedItem = value),
              validator: (value) {
                if (value == null) {
                  return 'This field is required';
                }
                return null;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                  elevation: 0,
                  onPressed: () {
                    if(widget.action == 'Add') {
                      _requestItemDetailBloc.add(AddRequestItemDetailButtonPressed(
                        requestItem: widget.requestItem,
                        item: _selectedItem,
                        amount: int.parse(_amountCtrl.text),
                      ));
                    } else if (widget.action == 'Edit') {
                      RequestItemDetail itemDetail = widget.requestItemDetail
                        ..item = _selectedItem
                        ..amount = int.parse(_amountCtrl.text);

                      _requestItemDetailBloc.add(EditRequestItemDetailButtonPressed(
                        requestItemDetail: itemDetail
                      ));
                    }
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