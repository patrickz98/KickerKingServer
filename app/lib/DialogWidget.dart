import 'package:flutter/material.dart';

import 'Simple.dart';

class CustomDialog extends ModalRoute<void>
{
    final CustomDialogWidget body;

    CustomDialog({
        @required this.body,
    }) : assert(body != null);

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
                child: body,
            ),
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
            child: child,
        );
    }
}

abstract class CustomDialogWidget extends StatefulWidget
{
    final String title;

    CustomDialogWidget({
        @required this.title,
    }) : assert(title != null);

//    @override
//    State createState() => CustomDialogWidgetState();
}

abstract class CustomDialogWidgetState extends State<CustomDialogWidget>
{
    static const _radius = 20.0;
    static const _barHeight = 50.0;
    static const _barColor = Defines.contentColor;

    bool get okEnabled => false;
    Color get actionColor => Defines.textColor;

    Widget _title()
    {
        Container container = Container(
            height: _barHeight,
            decoration: BoxDecoration(
                color: _barColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(_radius),
                    topRight: Radius.circular(_radius)
                )
            ),
            child: Center(
                child: Text(
                    widget.title,
                    style: TextStyle(
                        color: Defines.textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                    ),
                )
            )
        );

        Row expand = Row(
            children: [
                Expanded(child: container)
            ]
        );

        return expand;
    }

    Widget _buttons()
    {
        Widget okButton = GestureDetector(
            child: Container(
                height: _barHeight,
                decoration: BoxDecoration(
                    color: _barColor,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(_radius)
                    )
                ),
                child: Center(
                    child: Text(
                        "OK",
                        style: TextStyle(color: okEnabled ? actionColor : Defines.barColor)
                    )
                ),
                margin: EdgeInsets.all(0),
            ),
            onTap: okEnabled ? onOk : null,
        );

        Widget cancelButton = GestureDetector(
            child: Container(
                height: _barHeight,
                decoration: BoxDecoration(
                    color: _barColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(_radius)
                    )
                ),
                child: Center(
                    child: Simple.text("Cancel")
                ),
                margin: EdgeInsets.all(0),
            ),
            onTap: onCancel,
        );

        Row row = Row(
            children: [
                Expanded(child: cancelButton),
                Container(width: 2),
                Expanded(child: okButton),
            ]
        );

        return row;
    }

    Widget getBody(BuildContext context);

    void onOk()
    {
        Navigator.of(context).pop();
    }

    void onCancel()
    {
        Navigator.of(context).pop();
    }

    @override
    Widget build(BuildContext context)
    {
        Widget body = getBody(context);

        Widget container = Container(
//            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Defines.contentColor,
                borderRadius: BorderRadius.all(Radius.circular(_radius))
            ),
            child: Column(
                children: [
                    _title(),
                    Expanded(
                        child: SingleChildScrollView(
                            child: body
                        )
                    ),
                    _buttons()
                ],
            ),
        );

        Container sized = Container(
//            margin: EdgeInsets.only(top: 56), + SafeArea
            padding: EdgeInsets.all(20.0),
            constraints: BoxConstraints(
                minWidth: 350,
                minHeight: 350,
                maxWidth: 400,
                maxHeight: 600,
            ),
            child: container,
        );

        return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                sized
            ],
        );
    }
}