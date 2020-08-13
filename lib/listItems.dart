import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'myItem.dart';

class ListItems extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  ListItems({@required this.scaffoldKey}): super();

  @override
  _ListItemsState createState() => _ListItemsState();
}

class _ListItemsState extends State<ListItems> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: TodoList.items.length,
        itemBuilder: (BuildContext context, int index) {
          // if selected we show a checked icon otherwise show empty square
          Icon icon = TodoList.items[index].selected
              ? Icon(FontAwesomeIcons.checkSquare)
              : Icon(FontAwesomeIcons.square);
          return ListTile(
            leading: icon,
            title: Text(TodoList.items[index].title),
            onTap: () {
              setState(() {
                TodoList.items[index].selected =
                !TodoList.items[index].selected;
              });
            },
            trailing: FlatButton(
              child: Icon(FontAwesomeIcons.trash),
              onPressed: (){
                displayDeleteDialog(context, index);
              },
            ),
          );
        });
  }

  displayDeleteDialog(BuildContext context, int index) async {
    return showDialog(
        context: context,
        builder: (context) {
          String itemTitle = TodoList.items[index].title;
          return AlertDialog(
            title: Text('Remove Item'),
            content: Text('Are you sure you wish to remove $itemTitle ?'),
            actions: <Widget>[
              RaisedButton.icon(
                label: Text('YES'),
                icon: Icon(FontAwesomeIcons.trashAlt),
                color: Colors.redAccent.shade200,
                onPressed: () {
                  setState(() {
                    TodoList.items.removeAt(index);
                  });
                  Navigator.of(context).pop();
                  final snackBar = SnackBar(content: Text('Item Removed'));
                  widget.scaffoldKey.currentState.showSnackBar(snackBar);
                },
              ),
              RaisedButton.icon(
                label: Text('NO'),
                icon: Icon(FontAwesomeIcons.timesCircle),
                color: Colors.blueGrey,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }
}