import 'package:flutter/material.dart';
import 'dart:convert';

import 'Simple.dart';
import 'GameManager.dart';
import 'AddGameDialog.dart';

class GamesWidget extends StatefulWidget
{
    final GameManager gameManager;

    GamesWidget({
        @required this.gameManager
    }) : assert(gameManager != null);

    @override
    State createState() => _GamesWidgetSate();
}

class _GamesWidgetSate extends State<GamesWidget>
{
    @override
    Widget build(BuildContext context)
    {
        TableRow row1 = TableRow(
            children: [
                Center(child: Simple.text("Team 1", TextStyle(fontWeight: FontWeight.bold))),
                Center(child: Simple.text("Team 2", TextStyle(fontWeight: FontWeight.bold))),
                Center(child: Simple.text("Result",  TextStyle(fontWeight: FontWeight.bold))),
            ]
        );

        List<TableRow> rows = [row1];

        widget.gameManager.all().forEach((Game game)
        {
            String team1 = game.winner.join("\n");
            String team2 = game.looser.join("\n");
            String result = "${game.winnerPoints}:${game.looserPoints}";

            // TextStyle(color: Color(0xff43D08A))
            // TextStyle(color: Color(0xffE05252))

            TableRow row2 = TableRow(
                children: [
                    Text(
                        team1,
                        style: TextStyle(color: Defines.textColor),
                        textAlign: TextAlign.center,
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

        Container tableContainer = Container(child: table, padding: EdgeInsets.all(8.0));

        return tableContainer;
    }
}
