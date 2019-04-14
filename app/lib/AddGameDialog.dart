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
            body: _AddGameWidget(
                title: "Add Game",
                gameManager: gameManager
            ),
        );
    }
}

class _AddGameWidget extends CustomDialogWidget
{
    final GameManager gameManager;
    final String title;

    _AddGameWidget({
        @required this.title,
        @required this.gameManager
    }) : assert(gameManager != null), super(title: title);

    @override
    State createState() => _AddGameWidgetState(gameManager);
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

    List<String> _player = ["Patrick", "Daniel", "Ole", "Pascal", "Thomas"];

    final GameManager gameManager;

    _AddGameWidgetState(this.gameManager);

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

        _player.forEach((String player)
        {
            if (player == _selectedWinner2 ||
                player == _selectedLooser1 ||
                player == _selectedLooser2)
            {
                return;
            }


            DropdownMenuItem<String> item = DropdownMenuItem<String>(
                value: player,
                child: Text(player)
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

        _player.forEach((String player)
        {
            if (player == _selectedLooser1 ||
                player == _selectedLooser2 ||
                player == _selectedWinner1)
            {
                return;
            }

            DropdownMenuItem<String> item = DropdownMenuItem<String>(
                value: player,
                child: Text(player)
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

        _player.forEach((String player)
        {
            if (player == _selectedWinner1 ||
                player == _selectedWinner2 ||
                player == _selectedLooser2)
            {
                return;
            }

            DropdownMenuItem<String> item = DropdownMenuItem<String>(
                value: player,
                child: Text(player)
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

        _player.forEach((String player)
        {
            if (player == _selectedWinner1 ||
                player == _selectedWinner2 ||
                player == _selectedLooser1)
            {
                return;
            }

            DropdownMenuItem<String> item = DropdownMenuItem<String>(
                value: player,
                child: Text(player)
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

        Game game = Game
        (
            winner: [_selectedWinner1],
            looser: [_selectedLooser1],
            winnerPoints: _winnerPoints,
            looserPoints: _looserPoints,
            date: new DateTime.now()
        );

        gameManager.add(game);
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
