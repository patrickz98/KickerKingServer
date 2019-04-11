import 'package:flutter/material.dart';

import 'Simple.dart';

class WelcomeWidget extends StatelessWidget
{
    PageController _controller = PageController();
    BuildContext _context;


    void _nextPage()
    {
        _controller.nextPage(
            duration: Duration(milliseconds: 250),
            curve: Curves.ease
        );
    }

    void _popWelcome()
    {
//        Navigator.pop(_context);
    }

    Widget _page1()
    {
        Widget headline = Container(
            child: Text(
                "Welcome to Kicker King",
                style: TextStyle(
                    color: Defines.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                ),
                textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.all(8.0),
            constraints: BoxConstraints(
                maxWidth: 300,
            ),
        );

        Widget text = Container(
            child: Text(
                "This app is an Open-Source projekt. Developed with ❤️ by Patrick Zierahn.",
                style: TextStyle(
                    color: Defines.textColor,
                    fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.all(8.0),
            constraints: BoxConstraints(
                maxWidth: 300,
            ),
        );

        Icon icon = Icon(Icons.arrow_forward, color: Colors.blue);

        Text nextText = Text(
            "Next",
            style: TextStyle(color: Colors.blue),
        );

        FlatButton next = FlatButton(
            child: nextText,
            onPressed: _nextPage,
        );
//        OutlineButton next = OutlineButton(
//            child: nextText,
//            color: Colors.blue,
//            onPressed: (){},
//        );

//        IconButton next = IconButton(
//            icon: icon,
//            iconSize: 50,
//            onPressed: (){},
//            padding: EdgeInsets.all(0.0),
//        );
//
//        Container nextContainer = Container(
//            constraints: BoxConstraints.tight(Size.square(75)),
//            decoration: BoxDecoration(
//                color: Defines.barColor,
//                borderRadius: BorderRadius.all(Radius.circular(50))
//            ),
//            child: Center(child: next),
//            padding: EdgeInsets.all(0),
//            margin: EdgeInsets.all(10),
//        );

        Widget page1 = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                headline,
                text,
                next,
            ]
        );

        return page1;
    }

    Widget _page2()
    {
        Widget headline = Container(
            child: Text(
                "Simply sync your devices.",
                style: TextStyle(
                    color: Defines.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                ),
                textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.all(8.0),
            constraints: BoxConstraints(
                maxWidth: 300,
            ),
        );

        Widget text = Container(
            child: Text(
                "Open Kicker King > Settings > Sync Divices",
                style: TextStyle(
                    color: Defines.textColor,
                    fontWeight: FontWeight.w100,
                ),
                textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.all(8.0),
            constraints: BoxConstraints(
                maxWidth: 300,
            ),
        );

        FlatButton next = FlatButton(
            child: Text(
                "Next",
                style: TextStyle(
                    color: Colors.blue
                )
            ),
            onPressed: _nextPage
        );

        Widget page2 = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Simple.circleIcon(Icons.sync, 100),
                headline,
                text,
                next
            ]
        );

        return page2;
    }

    Widget _page3()
    {
        Widget headline = Container(
            child: Text(
                "Create a Username or Sync with other account",
                style: TextStyle(
                    color: Defines.textColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                ),
                textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.all(8.0),
            constraints: BoxConstraints(
                maxWidth: 300,
            ),
        );

        FlatButton next = FlatButton(
            child: Text(
                "Done",
                style: TextStyle(
                    color: Colors.blue
                )
            ),
            onPressed: _popWelcome
        );

        Widget page3 = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                headline,
                next
            ]
        );

        return page3;
    }

    @override
    Widget build(BuildContext context)
    {
        _context = context;

        // Look: https://medium.com/flutter-community/a-deep-dive-into-pageview-in-flutter-with-custom-transitions-581d9ea6dded
        Widget body = PageView(
            controller: _controller,
            children: <Widget>[
                Container(
                    child: _page1(),
                ),
                Container(
                    child: _page2(),
                ),
                Container(
                    child: _page3(),
                ),
            ],
        );

        return Scaffold(
            backgroundColor: Defines.contentColor,
            body: SafeArea(child: body),
        );
    }
}
