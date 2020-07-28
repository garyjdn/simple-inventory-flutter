import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/modules/modules.dart';

class TmpSupplierMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        automaticallyImplyLeading: true,
        title: Text('Supplier'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.add),
        onPressed: () {},
      ),
      body: BlocConsumer<SupplierBloc, SupplierState>(
        listener: (context, state) {},
        builder: (context, state) {
          if(state is SupplierLoadStarted) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is SupplierLoadSuccess) {
            return ListView(
              padding: EdgeInsets.all(15.0),
              children: state.suppliers.map((supplier) => Card(
                elevation: 0,
                child: ListTile(
                  title: Text(
                    supplier.name,
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(FontAwesomeIcons.trash),
                        iconSize: 18,
                      ),
                      // SizedBox(width: 8),
                      IconButton(
                        onPressed: () {},
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