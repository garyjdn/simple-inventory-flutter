import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';

class TmpSupplierMain extends StatelessWidget {

  void deleteDialog(BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) => CustomDialog(
        title: 'Delete Supplier?',
        content: Text('You will permanently remove this item'),
        primaryButton: PrimaryButton(
          onPressed: () {},
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
    SupplierBloc _supplierBloc = BlocProvider.of<SupplierBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        // automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Supplier'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.add),
        onPressed: () async {
          final fetch = await Navigator
            .of(context)
            .pushNamed(
              SupplierFormScreen.routeName, 
              arguments: SupplierFormScreenArguments(
                title: 'Add Supplier', 
                action: 'create'));

          if(fetch != null && fetch)
            _supplierBloc.add(LoadSupplierStarted());
        },
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
                  leading: Icon(
                    FontAwesomeIcons.userCheck,
                    color: Color(0xff5a5a5a),
                  ),
                  title: Text(
                    supplier.name,
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                  subtitle: Text(
                    supplier.phone,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => deleteDialog(context),
                        icon: Icon(FontAwesomeIcons.trash),
                        iconSize: 18,
                      ),
                      // SizedBox(width: 8),
                      IconButton(
                        onPressed: () async {
                          final fetch = await Navigator
                            .of(context)
                            .pushNamed(
                              SupplierFormScreen.routeName, 
                              arguments: SupplierFormScreenArguments(
                                title: 'Edit Supplier', 
                                action: 'edit',
                                supplier: supplier));
                          
                          if(fetch != null && fetch)
                          _supplierBloc.add(LoadSupplierStarted());
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