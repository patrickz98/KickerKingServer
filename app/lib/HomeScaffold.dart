import 'package:flutter/material.dart';

import 'Simple.dart';
import 'GamesWidget.dart';
import 'SettingsScaffold.dart';
import 'Welcome.dart';
import 'PlayerWidget.dart';
import 'AddGameDialog.dart';
import 'TableWrapper.dart';
import 'GameScoresWidget.dart';

class HomeScaffold extends StatefulWidget
{
    HomeScaffold({Key key}) : super(key: key);
    
    @override
    _HomeScaffoldState createState() => _HomeScaffoldState();
}

class _HomeScaffoldState extends State<HomeScaffold>
{
    int _pageIndex = 0;

    bool _showLoading = true;

    TableWrapper _table = TableWrapper();

    Widget buildNavigationBar()
    {
        Icon gamesIcon = Icon(Icons.list);
        BottomNavigationBarItem games = BottomNavigationBarItem(
            icon: gamesIcon,
            title: Text("Games")
        );

        Icon scoreIcon = Icon(Icons.show_chart);
        BottomNavigationBarItem scores = BottomNavigationBarItem(
            icon: scoreIcon,
            title: Text("Scores"),
        );

        Icon playerIcon = Icon(Icons.people);
        BottomNavigationBarItem player = BottomNavigationBarItem(
            icon: playerIcon,
            title: Text("Player"),
        );

        BottomNavigationBar bar = BottomNavigationBar(
            items: [scores, games, player],
            selectedItemColor: _table.color,
            elevation: Defines.elevation,
            backgroundColor: Defines.barColor,
            unselectedItemColor: Defines.barTextColor,
            currentIndex: _pageIndex,
            onTap: (int index)
            {
                setState(()
                {
                    _pageIndex = index;
                });
            },
        );

        return bar;
    }

    @override
    Widget build(BuildContext context)
    {
        List<Widget> tables = [];

        for (int inx = 0; inx < Defines.tableColors.length; inx++)
        {
            ListTile tile = ListTile(
                leading: Container(
                    constraints: BoxConstraints.expand(
                        width: 20,
                        height: 20
                    ),
                    decoration: BoxDecoration(
                        color: Defines.tableColors[ inx ],
                        borderRadius: BorderRadius.all(Radius.circular(20))
                    )
                ),
                title: Simple.text('Table $inx'),
                onTap: ()
                {
                    setState(()
                    {
                        _table.setTableIndex(inx);
                    });
                },
            );

            tables.add(tile);
        }

        tables.add(Divider(color: Defines.textColor));

        ListTile scan = ListTile(
            trailing: Icon(Icons.crop_free, color: Defines.textColor),
            title: Simple.text('Add table'),
            onTap: ()
            {
                setState(()
                {
                });
            },
        );
        tables.add(scan);

        ListTile conf = ListTile(
            trailing: Icon(Icons.settings, color: Defines.textColor),
            title: Simple.text('Settings'),
            onTap: ()
            {
                setState(()
                {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsScaffold(
                                table: _table
                            )
                        ),
                    );
                });
            },
        );
        tables.add(conf);

        Drawer drawer = Drawer(
            child: Container(
                color: Defines.contentColor,
                child: SafeArea(
                    child: ListView(
                        padding: EdgeInsets.zero,
                        children: tables,
                    )
                )
            ),
        );

        AppBar appBar = AppBar(
            title: Text("Table ${_table.table}", style: TextStyle(color: _table.color)),
            elevation: Defines.elevation,
            backgroundColor: Defines.barColor,
            brightness: Defines.brightness,
        );

        Widget body;

        if (_pageIndex == 0)
        {
            body = GameScoresWidget();
        }
        else if (_pageIndex == 1)
        {
            body = GamesWidget(table: _table);
        }
        else
        {
            body = PlayerWidget(table: _table);
        }

        Widget mainScaffold = Scaffold(
            backgroundColor: Defines.contentColor,
            appBar: appBar,
            body: Container(
                color: Defines.contentColor,
                margin: EdgeInsets.only(),
                child: body
            ),
            bottomNavigationBar: buildNavigationBar(),
            drawer: drawer,
            floatingActionButton: _pageIndex == 1 ? FloatingActionButton.extended(
                onPressed: ()
                {
                    AddGameDialog dialog = AddGameDialog(table: _table);
                    Navigator.of(context).push(dialog.build(context));
                },
                icon: Icon(Icons.add),
                backgroundColor: _table.color,
                elevation: Defines.elevation,
                label: Text("Add game results"),
            ) : null,
        );

        Stack content = Stack(
            children: [
                mainScaffold,
//                AddGameWidget(gameManager: _gamesManager)
            ]
        );

        return content;
    }
}
