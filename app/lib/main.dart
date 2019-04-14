import 'package:flutter/material.dart';

import 'Simple.dart';
import 'GamesWidget.dart';
import 'SettingsScaffold.dart';
import 'Welcome.dart';
import 'PlayerManager.dart';
import 'AddGameDialog.dart';
import 'TableWrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        return MaterialApp(
            title: 'Kicker King',
            home: MyHomePage(title: 'Kicker King'),
            debugShowCheckedModeBanner: false,
        );
    }
}

class MyHomePage extends StatefulWidget
{
    MyHomePage({Key key, this.title}) : super(key: key);

    final String title;

    @override
    _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
{
    int _tableIndex = 0;
    int _pageIndex = 0;

    bool showLoading = true;

    TableWrapper _table = TableWrapper();

    @override
    Widget build(BuildContext context)
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
                        MaterialPageRoute(builder: (context) => SettingsScaffold(
                            table: _table
                        )),
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

        GamesWidget gamesWidget = GamesWidget(table: _table);

        AppBar appBar = AppBar(
            title: Text(widget.title, style: TextStyle(color: _table.color)),
            elevation: Defines.elevation,
            backgroundColor: Defines.barColor,
            brightness: Defines.brightness,
        );

        Widget mainScaffold = Scaffold(
            backgroundColor: Defines.contentColor,
            appBar: appBar,
            body: Container(
                color: Defines.contentColor,
                margin: EdgeInsets.only(),
                child: _pageIndex == 1 ? gamesWidget : Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Text('No game scores pressent', style: TextStyle(color: Defines.barTextColor)),
                        ],
                    ),
                ),
            ),
            bottomNavigationBar: BottomNavigationBar(
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
                        _pageIndex = index != 2 ? index : _pageIndex;
                    });
                },
            ),
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
