import 'package:flutter/material.dart';
import 'Simple.dart';

import 'TableWrapper.dart';

class PlayerWidget extends StatefulWidget
{
    final TableWrapper table;

    PlayerWidget({
        @required this.table
    }) : assert(table != null);

    @override
    State<StatefulWidget> createState() => _PlayerWidgetState();
}

class _PlayerWidgetState extends State<PlayerWidget>
{
    Widget _paddingCenter(Widget child)
    {
        return Container(
            padding: EdgeInsets.all(6.0),
            child: Center(
                child: child,
            ),
        );
    }

    @override
    Widget build(BuildContext context)
    {
        List<TableRow> rows = [];

        TableRow row = TableRow(
            children: [
//                Container(),
                _paddingCenter(Simple.text("Player")),
                _paddingCenter(Simple.text("Id")),
            ]
        );

        rows.add(row);

        widget.table.player.player.forEach((String id, String player)
        {
            TableRow row = TableRow(
                children: [
//                    IconButton(
//                        icon: Icon(Icons.notifications_active, color: Defines.textColor),
//                        onPressed: (){}
//                    ),
                    _paddingCenter(Simple.text(player)),
                    _paddingCenter(Simple.text(id)),
                ]
            );

            rows.add(row);
        });

//        Map<int, TableColumnWidth> columnWidths = new Map();
//        columnWidths[ 0 ] = IntrinsicColumnWidth();
//        columnWidths[ 1 ] = FlexColumnWidth(1.0);
//        columnWidths[ 2 ] = FlexColumnWidth(1.0);

        Table table = Table(
//            columnWidths: columnWidths,
            children: rows,
        );

        return Container(
//            color: Colors.orange,
            child: table,
        );
    }
}
