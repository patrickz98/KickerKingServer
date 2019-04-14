import 'package:flutter/material.dart';

import 'Simple.dart';
import 'TableWrapper.dart';

class GamesWidget extends StatefulWidget
{
    final TableWrapper table;

    GamesWidget({
        @required this.table
    }) : assert(table != null);

    @override
    State createState() => _GamesWidgetSate();
}

class _GamesWidgetSate extends State<GamesWidget>
{
    @override
    void initState()
    {
        super.initState();
        widget.table.games.addListener(_updateTable);
    }

    @override
    void dispose()
    {
        super.dispose();
        widget.table.games.removeListener(_updateTable);
    }

    void _updateTable()
    {
        setState((){});
    }

    Widget _paddingContainer(Widget child)
    {
        return Container(
            padding: EdgeInsets.all(6.0),
            child: child,
        );
    }

    @override
    Widget build(BuildContext context)
    {
        TableRow row1 = TableRow(
            decoration: BoxDecoration(
                color: widget.table.color,
            ),
            children: [
                _paddingContainer(Center(child: Simple.text("Winner Team", TextStyle(fontWeight: FontWeight.bold)))),
                _paddingContainer(Center(child: Simple.text("Looser Team", TextStyle(fontWeight: FontWeight.bold)))),
                _paddingContainer(Center(child: Simple.text("Result",      TextStyle(fontWeight: FontWeight.bold)))),
            ]
        );

        List<TableRow> rows = [row1];

        widget.table.games.all().forEach((Game game)
        {
            String team1 = game.winner.join("\n");
            String team2 = game.looser.join("\n");
            String result = "${game.winnerPoints}:${game.looserPoints}";

            // TextStyle(color: Color(0xff43D08A))
            // TextStyle(color: Color(0xffE05252))

            TableRow row2 = TableRow(
                children: [
                    _paddingContainer(
                        Text(
                            team1,
                            style: TextStyle(color: Defines.textColor),
                            textAlign: TextAlign.center,
                        )
                    ),
                    Text(
                        team2,
                        style: TextStyle(color: Defines.textColor),
                        textAlign: TextAlign.center,
                    ),
                    Text(
                        result,
                        style: TextStyle(color: Defines.textColor),
                        textAlign: TextAlign.center,
                    ),
                ],
                decoration: BoxDecoration(
                    color: (rows.length % 2 == 0) ? Color(0xff24292E) : null,
                )
            );

            rows.add(row2);
        });

        Table table = Table(
            children: rows,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle
        );

        Container tableContainer = Container(
            child: table,
//            padding: EdgeInsets.all(8.0)
        );

        return tableContainer;
    }
}
