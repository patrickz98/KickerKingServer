import 'package:flutter/material.dart';

import 'DialogWidget.dart';
import 'Simple.dart';
import 'TableWrapper.dart';

export 'DialogWidget.dart';

class AddGameDialog
{
    final TableWrapper table;

    AddGameDialog({
        @required this.table
    }) : assert(table != null);

    CustomDialog build(BuildContext context)
    {
        return CustomDialog(
            body: _AddGameWidget(
                title: "Add Game",
                table: table,
            ),
        );
    }
}

class _AddGameWidget extends CustomDialogWidget
{
    final TableWrapper table;
    final String title;

    _AddGameWidget({
        @required this.title,
        @required this.table,
    }) : assert(table != null), super(title: title);

    @override
    State createState() => _AddGameWidgetState(table);
}

class _AddGameWidgetState extends CustomDialogWidgetState
{
    String _selectedWinner1;
    String _selectedLooser1;
    String _selectedWinner2;
    String _selectedLooser2;

    bool _showWinner2 = false;
    bool _showLooser2 = false;

    int _maxPoints = 10;
    int _winnerPoints = 10;
    int _looserPoints = 0;

    final TableWrapper table;

    _AddGameWidgetState(this.table);

    @override
    Color get actionColor => table.color;

    Theme _coloredDropdown(DropdownButton button)
    {
        return Theme(
            data: ThemeData(
                canvasColor: Defines.contentColor
            ),
            child: button,
        );
    }

    TableRow _winnerList()
    {
        List<DropdownMenuItem<String>> items = [];

        table.player.player.forEach((String playerId, String nick)
        {
            if (playerId == _selectedWinner2 ||
                playerId == _selectedLooser1 ||
                playerId == _selectedLooser2)
            {
                return;
            }


            DropdownMenuItem<String> item = DropdownMenuItem<String>(
                value: playerId,
                child: Text(nick)
            );

            items.add(item);
        });

        DropdownButton button = DropdownButton<String>(
            style: TextStyle
            (
                color: Defines.textColor,
            ),
            isExpanded: true,
            value: _selectedWinner1,
            items: items,
            onChanged: (String value)
            {
                setState(()
                {
                    _selectedWinner1 = value;
                });
            }
        );

        TableRow row = TableRow(
            children: [
                Simple.text("Winner Team"),
                _coloredDropdown(button),
            ]
        );

        return row;
    }

    TableRow _winnerList2()
    {
        List<DropdownMenuItem<String>> items = [];

        table.player.player.forEach((String playerId, String nick)
        {
            if (playerId == _selectedLooser1 ||
                playerId == _selectedLooser2 ||
                playerId == _selectedWinner1)
            {
                return;
            }

            DropdownMenuItem<String> item = DropdownMenuItem<String>(
                value: playerId,
                child: Text(nick)
            );

            items.add(item);
        });

        DropdownButton button = DropdownButton<String>(
            style: TextStyle
            (
                color: Defines.textColor,
            ),
            isExpanded: true,
            value: _selectedWinner2,
            items: items,
            onChanged: (String value)
            {
                setState(()
                {
                    _selectedWinner2 = value;
                });
            }
        );

        TableRow row = TableRow(
            children: [
                Container(),
                _coloredDropdown(button),
            ]
        );

        return row;
    }

    TableRow _looserList()
    {
        List<DropdownMenuItem<String>> items = [];

        table.player.player.forEach((String playerId, String nick)
        {
            if (playerId == _selectedWinner1 ||
                playerId == _selectedWinner2 ||
                playerId == _selectedLooser2)
            {
                return;
            }

            DropdownMenuItem<String> item = DropdownMenuItem<String>(
                value: playerId,
                child: Text(nick)
            );

            items.add(item);
        });

        DropdownButton button = DropdownButton<String>(
            style: TextStyle
            (
                color: Defines.textColor,
            ),
            isExpanded: true,
            value: _selectedLooser1,
            items: items,
            onChanged: (String value)
            {
                setState(()
                {
                    _selectedLooser1 = value;
                });
            }
        );

        TableRow row = TableRow(
            children: [
                Simple.text("Looser Team"),
                _coloredDropdown(button),
            ]
        );

        return row;
    }

    TableRow _looserList2()
    {
        List<DropdownMenuItem<String>> items = [];

        table.player.player.forEach((String playerId, String nick)
        {
            if (playerId == _selectedWinner1 ||
                playerId == _selectedWinner2 ||
                playerId == _selectedLooser1)
            {
                return;
            }

            DropdownMenuItem<String> item = DropdownMenuItem<String>(
                value: playerId,
                child: Text(nick)
            );

            items.add(item);
        });

        DropdownButton button = DropdownButton<String>(
            style: TextStyle
            (
                color: Defines.textColor,
            ),
            isExpanded: true,
            value: _selectedLooser2,
            items: items,
            onChanged: (String value)
            {
                setState(()
                {
                    _selectedLooser2 = value;
                });
            }
        );

        TableRow row = TableRow(
            children: [
                Container(),
                _coloredDropdown(button),
            ]
        );

        return row;
    }

    TableRow _winnerPointsList()
    {
        List<DropdownMenuItem<int>> items = [];

        for (int inx = _looserPoints + 1; inx <= _maxPoints; inx++)
        {
            DropdownMenuItem<int> item = DropdownMenuItem<int>(
                value: inx,
                child: Text("$inx")
            );

            items.add(item);
        }

        DropdownButton<int> button = DropdownButton<int>(
            style: TextStyle
                (
                color: Defines.textColor,
            ),
            isExpanded: true,
            value: _winnerPoints,
            items: items,
            onChanged: (int value)
            {
                setState(()
                {
                    _winnerPoints = value;
                    _looserPoints = (_winnerPoints <= _looserPoints)
                        ? _winnerPoints - 1
                        : _looserPoints;
                });
            }
        );

        TableRow row = TableRow(
            children: [
                Container(
                    child: Simple.text("Winner Points"),
                    padding: EdgeInsets.only(right: 10.0),
                ),
                _coloredDropdown(button),
            ],
        );

        return row;
    }

    TableRow _looserPointsList()
    {
        List<DropdownMenuItem<int>> items = [];

        for (int inx = 0; inx < _winnerPoints; inx++)
        {
            DropdownMenuItem<int> item = DropdownMenuItem<int>(
                value: inx,
                child: Text("$inx")
            );

            items.add(item);
        }

        DropdownButton<int> button = DropdownButton<int>(
            style: TextStyle
                (
                color: Defines.textColor,
            ),
            isExpanded: true,
            value: _looserPoints,
            items: items,
            onChanged: (int value)
            {
                setState(()
                {
                    _looserPoints = value;
                });
            }
        );

        TableRow row = TableRow(
            children: [
                Container(
                    child: Simple.text("Looser Points"),
                    padding: EdgeInsets.only(right: 10.0),
                ),
                _coloredDropdown(button),
            ]
        );

        return row;
    }

    @override
    bool get okEnabled => (_selectedWinner1 != null) && (_selectedLooser1 != null);

    @override
    void onOk()
    {
        super.onOk();

        List<String> winner = [_selectedWinner1];
        List<String> looser = [_selectedLooser1];

        if (_selectedWinner2 != null) winner.add(_selectedWinner2);
        if (_selectedLooser2 != null) looser.add(_selectedLooser2);

        Game game = Game
        (
            winner: winner,
            looser: looser,
            winnerPoints: _winnerPoints,
            looserPoints: _looserPoints,
            date: new DateTime.now()
        );

        table.games.add(game);
    }

    @override
    Widget getBody(BuildContext context)
    {
        List<TableRow> rows = [];
        rows.add(_winnerList());

        TableRow addWinner = TableRow(
            children: [
                Container(),
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                    children:
                    [
                        RaisedButton.icon
                        (
                            label: Simple.text("Add Winner"),
                            icon: Icon(Icons.add, color: Defines.textColor),
                            onPressed: ()
                            {
                                setState(()
                                {
                                    _showWinner2 = true;
                                });
                            },
                            color: Defines.barColor,
                        )
                    ],
                )
            ]
        );

        if (_showWinner2)
        {
            rows.add(_winnerList2());
        }
        else
        {
            rows.add(addWinner);
        }

        rows.add(_looserList());

        TableRow addLooser = TableRow(
            children: [
                Container(),
                Row(
                mainAxisAlignment: MainAxisAlignment.end,
                    children:
                    [
                        RaisedButton.icon
                        (
                            label: Simple.text("Add Looser"),
                            icon: Icon(Icons.add, color: Defines.textColor),
                            onPressed: ()
                            {
                                setState(()
                                {
                                    _showLooser2 = true;
                                });
                            },
                            color: Defines.barColor,
                        )
                    ],
                )
            ]
        );

        if (_showLooser2)
        {
            rows.add(_looserList2());
        }
        else
        {
            rows.add(addLooser);
        }

        rows.add(_winnerPointsList());
        rows.add(_looserPointsList());

        Map<int, TableColumnWidth> columnWidths = new Map();
        columnWidths[ 0 ] = IntrinsicColumnWidth();
        columnWidths[ 1 ] = FlexColumnWidth(2.0);

        Table table = Table(
            columnWidths: columnWidths,
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: rows,
        );

        return Container(
            child: table,
            margin: EdgeInsets.all(20),
        );
    }
}
