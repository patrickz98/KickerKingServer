import 'package:flutter/material.dart';
import 'Simple.dart';

import 'PlayerManager.dart';
import 'GameManager.dart';

export 'PlayerManager.dart';
export 'GameManager.dart';

class TableData
{
    final PlayerManager player = PlayerManager();
    final GameManager games = GameManager();

    Color get color => Color(0xffAC64FF);

    
}