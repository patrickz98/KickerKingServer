import 'package:flutter/material.dart';

import 'Simple.dart';
import 'TableWrapper.dart';

class SettingsScaffold extends StatefulWidget
{
    final TableWrapper table;

    SettingsScaffold({
        @required this.table,
    }) : assert(table != null);

    @override
    State<StatefulWidget> createState() => _SettingsScaffoldState();
}

class _SettingsScaffoldState extends State<SettingsScaffold>
{
    @override
    Widget build(BuildContext context)
    {
        List<Widget> tables = [];

        for (int inx = 0; inx < Defines.tableColors.length; inx++)
        {
            TableRow nameRow = TableRow(
                children: [
                    Simple.text("Name"),
                    TextField(
                        controller: TextEditingController(text: "Table $inx"),
                        style: TextStyle(color: Defines.textColor),
                    )
                ]
            );

            Map<String, Color> colorMap = new Map();
            List<String> colorStrs = [];

            Defines.tableColors.forEach((Color color)
            {
                colorStrs.add(color.value.toString());
                colorMap[ color.value.toString() ] = color;
            });

            TableRow colorRow = TableRow(
                children: [
                    Simple.text("Color"),
//                    Theme(
//                        data: Theme.of(context).copyWith(
//                            canvasColor: Defines.contentColor
//                        ),
//                        child: DropdownButton<String>(
//                            items: colorStrs.map((String value) {
//                                return DropdownMenuItem<String>(
//                                    value: value,
//                                    child: Text(value, style: TextStyle(color: colorMap[ value ])),
//                                );
//                            }).toList(),
//                            onChanged: (_) {},
//                        )
//                    ),
                    FlatButton(
                        onPressed: (){},
//                        elevation: Defines.elevation,
                        child: Simple.text("Change"),
                        color: Defines.tableColors[ inx ],
                    )
                ]
            );

            ListTile tile = ListTile(
                leading: FlatButton(onPressed: (){}, child: Container(
                    constraints: BoxConstraints.expand(
                        width: 20,
                        height: 20
                    ),
                    decoration: BoxDecoration(
                        color: Defines.tableColors[ inx ],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                )),
                title: Simple.text('Table $inx'),
                onTap: ()
                {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                            backgroundColor: Defines.contentColor,
                            title: Simple.text("Edit"),
                            content: Table(
                                children: [nameRow, colorRow],
                                defaultVerticalAlignment: TableCellVerticalAlignment.middle
                            ),
                            actions: <Widget>[
                                FlatButton(child: Text("CANCLE"), onPressed: ()
                                {
                                    Navigator.pop(context);
                                }),
                                FlatButton(child: Text("OK"), onPressed: (){}),
                            ],
                        )
                    );
                },
            );

            tables.add(tile);
        }

        Column column = Column(
            children: tables,
        );

        return Scaffold(
            backgroundColor: Defines.contentColor,
            appBar: AppBar(
                backgroundColor: Defines.barColor,
                elevation: Defines.elevation,
                brightness: Defines.brightness,
                title: Simple.text("Settings"),
            ),
            body: SafeArea(child: column),
        );
    }
}
