import 'package:flutter/material.dart';

import 'Simple.dart';
import 'GameManager.dart';

class TutorialOverlay extends ModalRoute<void>
{
    @override
    Duration get transitionDuration => Duration(milliseconds: 500);

    @override
    bool get opaque => false;

    @override
    bool get barrierDismissible => false;

    @override
    Color get barrierColor => Colors.black.withOpacity(0.5);

    @override
    String get barrierLabel => null;

    @override
    bool get maintainState => true;

    @override
    Widget buildPage(
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation
    )
    {
        // This makes sure that text and other content follows the material style
        return Material(
            type: MaterialType.transparency,
            // make sure that the overlay content is not cut off
            child: SafeArea(
//                child: _buildOverlayContent(context),
                child: DialogWidget(
                    title: "Test",
                    callback: (_)
                    {
                        Navigator.pop(context);
                    },
                ),
            ),
        );
    }

    Widget _buildOverlayContent(BuildContext context)
    {
        return Container(
            color: Colors.orange,
            child: Center(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                        Text(
                            'This is a nice overlay',
                            style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                        RaisedButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Dismiss'),
                        )
                    ],
                ),
            )
        );
    }

    @override
    Widget buildTransitions(
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child
    )
    {
        // You can add your own animations for the overlay content
//        return FadeTransition(
//            opacity: animation,
//            child: ScaleTransition(
//                scale: animation,
//                child: child,
//            ),
//        );
        return SlideTransition(
            position: Tween<Offset>(
                begin: const Offset(0.0, 1.0),
                end: Offset.zero,
            ).animate(
                CurvedAnimation(
                    parent: animation,
                    curve: Interval(
                        0.00,
                        0.50,
                        curve: Curves.ease,
                    ),
                )
            ),
            child: child, // child is the value returned by pageBuilder
        );
    }
}

class DialogWidget extends StatefulWidget
{
    final String title;
    final ValueChanged<int> callback;

    DialogWidget({
        @required this.title,
        @required this.callback
    }) : assert(title != null && callback != null);

    @override
    State createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget>
{
    @override
    Widget build(BuildContext context)
    {
        Widget body = Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(),
            child: Card(
                margin: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                ),
                color: Defines.contentColor,
                child: Container(
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.all(0),
                    padding: EdgeInsets.all(0),
                    child: Column(
                        children: [
                            Row(
                                children: [
                                    Expanded(
                                        child: Container(
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(
                                                        20),
                                                    topRight: Radius.circular(
                                                        20)
                                                )
                                            ),
                                            child: Center(
                                                child: Simple.text(widget.title)
                                            )
                                        ),
                                    )
                                ],
                            ),
                            Expanded(
                                child: Container()
                            ),
                            Row(
                                children: [
                                    Expanded(
                                        child: GestureDetector(
                                            child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius
                                                        .only(bottomLeft: Radius
                                                        .circular(20))
                                                ),
                                                child: Center(
                                                    child: Simple.text("Cancel")
                                                ),
                                                margin: EdgeInsets.all(0),
                                            ),
                                            onTap: ()
                                            {
                                                widget.callback(1);
                                            },
                                        ),
                                    ),
                                    Container(width: 2),
                                    Expanded(
                                        child: GestureDetector(
                                            child: Container(
                                                height: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius: BorderRadius
                                                        .only(
                                                        bottomRight: Radius
                                                            .circular(20))
                                                ),
                                                child: Center(
                                                    child: Simple.text("Add")
                                                ),
                                                margin: EdgeInsets.all(0),
                                            ),
                                        )
                                    ),
                                ],
                            )
                        ],
                    ),
                )
            ),
        );

        Container dimmer = Container(
//            color: Colors.black.withOpacity(0.5),
//            margin: EdgeInsets.only(top: 56), + SafeArea
            padding: EdgeInsets.all(20.0),
            child: SafeArea(child: body),
        );

        return dimmer;
    }
}