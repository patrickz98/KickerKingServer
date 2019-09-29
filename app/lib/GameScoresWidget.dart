import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'Simple.dart';

// https://google.github.io/charts/flutter/gallery.html
class OrdinalSales
{
    final int year;
    final int sales;

    OrdinalSales(this.year, this.sales);
}

class GameScoresWidget extends StatefulWidget
{
    GameScoresWidget({Key key}) : super(key: key);

    @override
    _GameScoresWidgetState createState() => _GameScoresWidgetState();
}

class _GameScoresWidgetState extends State<GameScoresWidget>
{
    final List<OrdinalSales> seriesList = [
        new OrdinalSales(1, 5),
        new OrdinalSales(2, 25),
        new OrdinalSales(3, 100),
        new OrdinalSales(4, 75),
    ];

    @override
    Widget build(BuildContext context)
    {
        Widget body = Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                    Text('No game scores pressent', style: TextStyle(color: Defines.barTextColor)),
                ],
            ),
        );

        List<charts.Series<OrdinalSales, int>> data = [
            new charts.Series<OrdinalSales, int>(
                id: 'Sales',
                colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                domainFn: (OrdinalSales sales, _) => sales.year,
                measureFn: (OrdinalSales sales, _) => sales.sales,
                data: seriesList
            )
        ];

        var barChart = charts.LineChart(
            data,
            animate: false,
        );

        return Container(
            height: 300,
            child: barChart,
        );
    }
}