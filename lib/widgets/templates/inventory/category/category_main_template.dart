import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:inventoryapp/data/data.dart';
import 'package:inventoryapp/modules/modules.dart';
import 'package:inventoryapp/widgets/widgets.dart';
import 'package:inventoryapp/widgets/components/custom_dialog.dart' as customDialog;

class TmpCategoryMain extends StatelessWidget {
  CategoryBloc _categoryBloc;

  Future deleteDialog(BuildContext ctx, Category category) async {
    return await showDialog(
      context: ctx,
      builder: (BuildContext context) => CustomDialog(
        title: 'Delete Category?',
        content: Text('You will permanently remove this item'),
        primaryButton: PrimaryButton(
          onPressed: () {
            Navigator.of(context).pop();
            _categoryBloc.add(DeleteCategoryButtonPressed(category: category));
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
    _categoryBloc = BlocProvider.of<CategoryBloc>(context);

    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        // automaticallyImplyLeading: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Category'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[300],
        child: Icon(Icons.add),
        onPressed: () async {
          final fetch = await Navigator
            .of(context)
            .pushNamed(
              CategoryFormScreen.routeName, 
              arguments: CategoryFormScreenArguments(
                title: 'Add Category', 
                action: 'create'));

          if(fetch != null && fetch)
            _categoryBloc.add(LoadCategoryStarted());
        },
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) async {
          if(state is CategoryDeleteSuccess) {
            await customDialog.showDialog(
              context: context,
              builder: (_) => MessageDialog(
                message: state.message
              )
            );
            _categoryBloc.add(LoadCategoryStarted());
          }
        },
        buildWhen: (prevState, state) {
          if(state is CategoryLoadStarted
          || state is CategoryLoadSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          if(state is CategoryLoadStarted) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if(state is CategoryLoadSuccess) {
            return ListView(
              padding: EdgeInsets.all(15.0),
              children: state.categories.map((category) => Card(
                elevation: 0,
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.palette,
                    color: Color(0xff5a5a5a),
                  ),
                  title: Text(
                    category.name,
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        onPressed: () => deleteDialog(context, category),
                        icon: Icon(FontAwesomeIcons.trash),
                        iconSize: 18,
                      ),
                      // SizedBox(width: 8),
                      IconButton(
                        onPressed: () async {
                          final fetch = await Navigator
                            .of(context)
                            .pushNamed(
                              CategoryFormScreen.routeName, 
                              arguments: CategoryFormScreenArguments(
                                title: 'Edit Category', 
                                action: 'edit',
                                category: category));
                          
                          if(fetch != null && fetch)
                          _categoryBloc.add(LoadCategoryStarted());
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