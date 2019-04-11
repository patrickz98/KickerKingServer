import 'package:flutter/material.dart';

import 'DialogWidget.dart';
import 'GameManager.dart';
import 'Simple.dart';

class AddGameWidget extends StatefulWidget
{
    final GameManager gameManager;

    AddGameWidget({
        @required this.gameManager
    }) : assert(gameManager != null);

    @override
    State createState() => _AddGameWidgetState();
}

class _AddGameWidgetState extends State<AddGameWidget>
{
    @override
    Widget build(BuildContext context)
    {
        return DialogWidget(
            title: "Add Game",
            callback: (_){},
        );
    }
}
