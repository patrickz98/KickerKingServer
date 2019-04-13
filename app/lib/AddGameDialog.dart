import 'package:flutter/material.dart';

import 'DialogWidget.dart';
import 'GameManager.dart';
import 'Simple.dart';

export 'DialogWidget.dart';

class AddGameDialog
{
    final GameManager gameManager;

    AddGameDialog({
        @required this.gameManager
    }) : assert(gameManager != null);

    CustomDialog build(BuildContext context)
    {
        return CustomDialog(
            title: "Add Game",
            body: _AddGameWidget(gameManager),
            ok: ()
            {
                Navigator.of(context).pop();
            },
            cancel: ()
            {
                Navigator.of(context).pop();
            },
        );
    }
}

class _AddGameWidget extends StatefulWidget
{
    final GameManager gameManager;

    _AddGameWidget(this.gameManager) : assert(gameManager != null);

    @override
    State createState() => _AddGameWidgetState();
}

class _AddGameWidgetState extends State<_AddGameWidget>
{
    String _selectedWinner;
    String _selectedLooser;

    @override
    Widget build(BuildContext context)
    {
        TableRow row1 = TableRow(
            children: [
                Simple.text("Winner"),
                Theme(
                    data: ThemeData(
                        canvasColor: Defines.contentColor

                    ),
                    child: DropdownButton<String>(
                        style: TextStyle(
                            color: Defines.textColor,
                        ),
                        isExpanded: true,
                        value: _selectedWinner,
                        items: [
                            DropdownMenuItem<String>(value: "id1", child: Text("Patrick")),
                            DropdownMenuItem<String>(value: "id2", child: Text("Daniel")),
                        ],
                        onChanged: (String value)
                        {
                            setState(()
                            {
                                _selectedWinner = value;
                            });
                        }
                    ),
                )
            ]
        );

        TableRow row2 = TableRow(
            children: [
                Simple.text("Looser"),
                Theme(
                    data: ThemeData(
                        canvasColor: Defines.contentColor

                    ),
                    child: DropdownButton(
                        style: TextStyle(
                            color: Defines.textColor,
                        ),
                        isExpanded: true,
                        value: _selectedLooser,
                        items: [
                            DropdownMenuItem(
                                value: "id1",
                                child: Text("Patrick")
                            ),
                            DropdownMenuItem(value: "id2", child: Text("Daniel")),
                        ],
                        onChanged: (String value)
                        {
                            setState(()
                            {
                                _selectedLooser = value;
                            });
                        }
                    ),
                )
            ]
        );

        List<Widget> _points = [];

        for (int inx = 0; inx < 16; inx++)
        {
            Container point = Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    color: Defines.barColor,
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    border: Border.all(
                        color: Colors.blue,

                    )
                ),
                child: Center(child: Simple.text("$inx")),
                margin: EdgeInsets.all(3)
            );

            _points.add(point);
        }

        TableRow row3 = TableRow(
            children: [
                Simple.text("Winner Points"),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: _points,
                    )
                )
            ]
        );

        TableRow row4 = TableRow(
            children: [
                Simple.text("Looser Points"),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        children: _points,
                    )
                )
            ]
        );

        Map<int, TableColumnWidth> columnWidths = new Map();
        columnWidths[ 0 ] = IntrinsicColumnWidth();
        columnWidths[ 1 ] = FlexColumnWidth(2.0);

        Table table = Table(
            columnWidths: columnWidths,
            children: [
                row1,
                row2,
                row3,
                row4
            ],
        );

        return Container(
//            color: Colors.orange
            child: table,
            margin: EdgeInsets.all(20),
        );
    }
}
