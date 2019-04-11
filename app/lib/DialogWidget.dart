import 'package:flutter/material.dart';

import 'Simple.dart';

class CustomDialog extends ModalRoute<void>
{
    final String title;
    final Widget body;
    final VoidCallback ok;
    final VoidCallback cancel;

    CustomDialog({
        @required this.title,
        @required this.body,
        @required this.ok,
        @required this.cancel
    }) : assert(
        title  != null &&
        body   != null &&
        ok     != null &&
        cancel != null
    );

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
                child: DialogWidget(
                    title: title,
                    body: body,
                    ok: ok,
                    cancel: cancel,
                ),
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

class DialogWidget extends StatefulWidget
{
    final String title;
    final Widget body;
    final VoidCallback ok;
    final VoidCallback cancel;

    DialogWidget({
        @required this.title,
        @required this.body,
        @required this.ok,
        @required this.cancel
    }) : assert(
        title  != null &&
        ok     != null &&
        cancel != null
    );

    @override
    State createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget>
{
    static const _radius = 20.0;
    static const _barHeight = 50.0;
    static const _barColor = Colors.blue;

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
                    child: Simple.text("OK")
                ),
                margin: EdgeInsets.all(0),
            ),
            onTap: widget.ok,
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
            onTap: widget.cancel,
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

    @override
    Widget build(BuildContext context)
    {
        Widget body = Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.all(0),
            child: Container(
                alignment: Alignment.topLeft,
                margin: EdgeInsets.all(0),
                padding: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    color: Defines.contentColor,
                    borderRadius: BorderRadius.all(Radius.circular(_radius))
                ),
                child: Column(
                    children: [
                        _title(),
                        Expanded(child: widget.body),
                        _buttons()
                    ],
                ),
            ),
        );

        Container dimmer = Container(
//            margin: EdgeInsets.only(top: 56), + SafeArea
            padding: EdgeInsets.all(20.0),
            child: SafeArea(child: body),
        );

        return dimmer;
    }
}