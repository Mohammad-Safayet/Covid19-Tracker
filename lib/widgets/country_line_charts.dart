import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class StatTimeSeriesChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final String name;

  StatTimeSeriesChart(
    this.seriesList, {
    this.animate,
    this.name,
  });

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: true,
      
      primaryMeasureAxis: charts.NumericAxisSpec(
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 13,
            fontWeight: "bold",
            color: charts.MaterialPalette.white,
          ),
          lineStyle: charts.LineStyleSpec(
            thickness: 0,
            color: charts.MaterialPalette.white,
          ),
        ),
      ),
      domainAxis: charts.DateTimeAxisSpec(
        showAxisLine: false,
        renderSpec: charts.GridlineRendererSpec(
          labelStyle: charts.TextStyleSpec(
            fontSize: 12,
            fontWeight: "bold",
            color: charts.MaterialPalette.white,
          ),
          lineStyle: charts.LineStyleSpec(
            thickness: 0,
          ),
        ),
      ),
      // behaviors: [
      //   new charts.ChartTitle(
      //     'Deaths',
      //     behaviorPosition: charts.BehaviorPosition.inside,
      //     titleOutsideJustification: charts.OutsideJustification.endDrawArea,
      //     innerPadding: 18,
      //     titleStyleSpec: charts.TextStyleSpec(
      //       fontFamily: 'JosefinSlab',
      //       color: charts.Color.white,
      //       fontWeight: 'bold',
      //     ),
      //   ),
      // ],
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      defaultRenderer: charts.LineRendererConfig(
        includeArea: true,
      ),
    );
  }
}
