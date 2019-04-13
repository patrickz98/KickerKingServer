import 'package:flutter/material.dart';

import 'Simple.dart';

class TableManager
{
    final ValueChanged<String> _tableChanged;

    String selected;
    List<String> tableIds;

    TableManager(this._tableChanged);

    void addTables(List<String> tables)
    {
        tableIds.addAll(tables);
    }

    void removeTable(String table)
    {
        tableIds.remove(table);
    }
}
