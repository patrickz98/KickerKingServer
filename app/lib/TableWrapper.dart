import 'package:flutter/material.dart';
import 'Simple.dart';

import 'PlayerManager.dart';
import 'GameManager.dart';

export 'PlayerManager.dart';
export 'GameManager.dart';

class TableWrapper
{
    final PlayerManager player = PlayerManager();
    final GameManager games = GameManager();

    int _tableIndex = 0;

    Color get color => Defines.tableColors[ _tableIndex ];

    void setTableIndex(int inx)
    {
        _tableIndex = inx;
    }
}