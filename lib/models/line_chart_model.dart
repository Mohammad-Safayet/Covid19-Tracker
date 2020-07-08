import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class TimeSeriesOccurance {
  final DateTime time;
  final int occurances;

  TimeSeriesOccurance({
    @required this.time,
    @required this.occurances,
  });
}

class ListTimeStampOccurances {
  static List<TimeSeriesOccurance> data = [];
  static Color color;

  static List<charts.Series<TimeSeriesOccurance, DateTime>> dataBinding(
      String reason) {
    return [
      charts.Series<TimeSeriesOccurance, DateTime>(
        id: '$reason',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(color),
        seriesColor: charts.Color.black,
        // patternColorFn: (_, __) => charts.Color.fromHex(code: "#ffffff"),
        // insideLabelStyleAccessorFn: (_, __) {
        //   return charts.TextStyleSpec(
        //     color: charts.ColorUtil.fromDartColor(Colors.amber)
        //   );
        // },
        domainFn: (TimeSeriesOccurance occurance, _) => occurance.time,
        measureFn: (TimeSeriesOccurance occurance, _) => occurance.occurances,
        data: data,
      )
    ];
  }
}
