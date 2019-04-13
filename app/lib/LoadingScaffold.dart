import 'package:flutter/material.dart';

import 'Simple.dart';

class LoadingScaffold extends StatelessWidget
{
    @override
    Widget build(BuildContext context)
    {
        Widget title = Text(
            "Connecting to server..."
        );

        return Scaffold(
            backgroundColor: Defines.contentColor,
            body: Center(
                child: CircularProgressIndicator()
            ),
        );
    }
}