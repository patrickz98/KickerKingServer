import 'package:flutter/material.dart';

import 'Simple.dart';
import 'TableWrapper.dart';

class AddTableWidget extends StatefulWidget
{
    final TableWrapper table;

    AddTableWidget({
        @required this.table,
    }) : assert(table != null);

    @override
    State<StatefulWidget> createState() => AddTableWidgetState();
}

class AddTableWidgetState extends State<AddTableWidget>
{
    Widget _iconButton(IconData icondata, String title, String desc)
    {
        Icon icon = Icon(icondata, color: Colors.white, size: 50);

        Container circle = Container(
            constraints: BoxConstraints(
                maxHeight: 100,
                minHeight: 100,
                maxWidth: 100,
                minWidth: 100,
            ),
//            decoration: BoxDecoration(
//                color: Color(0xff999999),
//                borderRadius: BorderRadius.all(Radius.circular(100))
//            ),
            child: Center(child: icon),
            padding: EdgeInsets.all(10.0),
        );

        Text text = Text(
            title,
            style: TextStyle(
                color: Defines.textColor,
                fontWeight: FontWeight.bold,
                fontSize: 25,
            ),
            textAlign: TextAlign.center,
        );

        Container textContainer = Container(
            child: text,
            padding: EdgeInsets.all(10.0),
        );

        Text disctText = Text(
            desc,
            style: TextStyle(
                color: Colors.grey,
                fontSize: 18,
            ),
            textAlign: TextAlign.center,
        );
        
        Column column = Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                textContainer,
                disctText,
                circle,
            ],
        );

        Container container = Container(
            child: column,
            padding: EdgeInsets.all(5.0),
        );

        FlatButton button = FlatButton(
            child: container,
            onPressed: ()
            {
//                widget.tableManager.setOk();
            },
        );

        return button;
    }

    @override
    Widget build(BuildContext context)
    {
        Column column = Column(
            children: <Widget>[
                Expanded(child: _iconButton(
                    Icons.create,
                    "New table",
                    "Click here to create a new fussball table."
                )),
                Divider(color: Colors.grey),
                Expanded(child: _iconButton(
                    Icons.add,
                    "Add table",
                    "Click here to add an existing fussball table."
                )),
            ],
        );

        return Scaffold(
            backgroundColor: Defines.contentColor,
//            appBar: AppBar(
//                backgroundColor: Defines.barColor,
//                elevation: Defines.elevation,
//                brightness: Defines.brightness,
//                title: Simple.text("Add Table"),
//            ),
//            body: SafeArea(child: Center(child: Simple.text("Welcome"))),
            body: SafeArea(child: column),
        );
    }
}
