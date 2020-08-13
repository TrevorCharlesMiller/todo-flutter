import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'myItem.dart';
import 'listItems.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade700,
        title: Text('My To Do List'),
      ),
      body: Container(
        child: ListItems(scaffoldKey: scaffoldKey),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: () => displayAddDialog(context),
        tooltip: 'Add Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  displayAddDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Add Item'),
            content: TextField(
              controller: textFieldController,
              decoration: InputDecoration(hintText: "Item Name"),
            ),
            actions: <Widget>[
              RaisedButton.icon(
                label: Text('ADD'),
                icon: Icon(FontAwesomeIcons.plusCircle),
                color: Colors.blueGrey,
                onPressed: () {
                  if (textFieldController.text.length>0) {
                    setState(() {
                      TodoList.items.add(MyItem(false, textFieldController.text));
                    });
                    Navigator.of(context).pop();
                    final snackBar = SnackBar(content: Text('Item Added'));
                    scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                },
              ),
              RaisedButton.icon(
                label: Text('CANCEL'),
                icon: Icon(FontAwesomeIcons.timesCircle),
                color: Colors.redAccent.shade200,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}