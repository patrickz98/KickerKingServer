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
//            body: _AddGameWidget(gameManager),
            body: Container(),
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
    @override
    Widget build(BuildContext context)
    {
        return Container(color: Colors.orange);
    }
}
