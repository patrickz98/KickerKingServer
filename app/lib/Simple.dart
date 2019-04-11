import 'package:flutter/material.dart';
import 'Defines.dart';

export 'Defines.dart';

class Simple
{
    static Text text(String str, [TextStyle style = const TextStyle()])
    {
        return Text(str, style: TextStyle(color: Defines.textColor).merge(style));
    }

    static Widget circleIcon(IconData data, double size)
    {
        Icon icon = Icon(data, color: Colors.white, size: size / 2);

        Container circle = Container(
            constraints: BoxConstraints(
                maxHeight: size,
                minHeight: size,
                maxWidth: size,
                minWidth: size,
            ),
            decoration: BoxDecoration(
                color: Color(0xff999999),
                borderRadius: BorderRadius.all(Radius.circular(size))
            ),
            child: Center(child: icon),
            padding: EdgeInsets.all(10.0),
        );

        return circle;
    }
}