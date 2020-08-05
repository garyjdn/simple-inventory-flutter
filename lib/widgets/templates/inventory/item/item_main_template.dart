import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;

class TmpItemMain extends StatelessWidget {
  ItemBloc _itemBloc;

  Future deleteDialog(BuildContext ctx, Item item) async {
    return await showDialog(
      context: ctx,
      builder: (BuildContext context) => CustomDialog(
        title: 'Delete Item?',
        content: Text('You will permanently remove this item'),
        primaryButton: PrimaryButton(
          onPressed: () {
            Navigator.of(context).pop();
            _itemBloc.add(DeleteItemButtonPressed(item: item));
          },
          text: 'Delete'
        ),
        secondaryButton: SecondaryButton(
          onPressed: () => Navigator.of(context).pop(),
          text: 'Cancel'
        ),
      )
    );
  }
  

  @override
  Widget build(BuildContext context) {
    _itemBloc = BlocProvider.of<ItemBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        // automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Item'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.add),
        onPressed: () async {
          final fetch = await Navigator
            .of(context)
            .pushNamed(
              ItemFormScreen.routeName, 
              arguments: ItemFormScreenArguments(
                title: 'Add Item', 
                action: 'create'));

          if(fetch != null && fetch)
            _itemBloc.add(LoadItemStarted());
        },
      ),
      body: BlocConsumer<ItemBloc, ItemState>(
        listener: (context, state) async {
          if(state is ItemDeleteSuccess) {
            await customDialog.showDialog(
              context: context,
              builder: (_) => MessageDialog(
                message: state.message
              )
            );
            _itemBloc.add(LoadItemStarted());
          }
        },
        buildWhen: (prevState, state) {
          if(state is ItemLoadStarted
          || state is ItemLoadSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if(state is ItemLoadStarted) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is ItemLoadSuccess) {
            return ListView(
              padding: EdgeInsets.all(15.0),
              children: state.items.map((item) => Card(
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.box,
                    color: Color(0xff5a5a5a),
                  ),
                  title: Text(
                    item.name,
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => deleteDialog(context, item),
                        icon: Icon(FontAwesomeIcons.trash),
                        iconSize: 18,
                      ),
                      // SizedBox(width: 8),
                      IconButton(
                        onPressed: () async {
                          final fetch = await Navigator
                            .of(context)
                            .pushNamed(
                              ItemFormScreen.routeName, 
                              arguments: ItemFormScreenArguments(
                                title: 'Edit Item', 
                                action: 'edit',
                                item: item));
                          
                          if(fetch != null && fetch)
                          _itemBloc.add(LoadItemStarted());
                        },
                        icon: Icon(FontAwesomeIcons.solidEdit),
                        iconSize: 18,
                      )
                    ],
                  ),
                ),
              )).toList()
            );
          } else {
            return Container();
          }
          
        }
      )
    );
  }
}