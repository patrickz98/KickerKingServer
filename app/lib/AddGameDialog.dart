import 'package:flutter/material.dart';

import 'GameManager.dart';
import 'Simple.dart';

class AddGameWidget extends StatefulWidget
{
    final GameManager gameManager;

    AddGameWidget({
        @required this.gameManager
    }) : assert(gameManager != null);

    @override
    State createState() => _AddGameWidgetState();

    static void show(BuildContext context, GameManager manager)
    {
        showDialog(
            context: context,
            builder: (BuildContext context)
            {
                return AlertDialog(
                    backgroundColor: Defines.contentColor,
                    title: Simple.text("Add Game Results"),
                    content: AddGameWidget(gameManager: manager),
                    actions: [
                        FlatButton(
                            child: Text("OK"),
                            onPressed: () {
                                Navigator.of(context).pop();
                            },
                        ),
                    ],
                );
            },
        );
    }
}

class _AddGameWidgetState extends State<AddGameWidget>
{
    @override
    Widget build(BuildContext context)
    {
        DropdownButton winnerSelect = DropdownButton<String>(
            items: <String>['A', 'B', 'C', 'D'].map((String value)
            {
                return DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                );
            }).toList(),
            onChanged: (_) {},
        );

        TextField winnerField = TextField(
            style: TextStyle(color: Defines.textColor),
        );

        TableRow winner = TableRow(
            children: [
                Simple.text("Winner"),
                winnerField
            ]
        );

        TextField looserField = TextField(
            style: TextStyle(color: Defines.textColor),
        );

        TableRow looser = TableRow(
            children: [
                Simple.text("Looser"),
                looserField
            ]
        );

        TableRow wPoints = TableRow(
            children: [
                Simple.text("Points"),
                TextFormField(
                    style: TextStyle(color: Defines.textColor),
                    keyboardType: TextInputType.number,
                ),
            ]
        );

        Table table = Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
                winner,
                looser,
                wPoints
            ],
        );

        return table;
    }
}