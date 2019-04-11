import 'package:flutter/material.dart';

class TableManager
{
    final ValueChanged<bool> changeEvent;
    bool ok = false;

    TableManager({
        @required this.changeEvent,
    }) : assert(changeEvent != null);

    void setOk()
    {
        ok = true;
        changeEvent(ok);
    }
}