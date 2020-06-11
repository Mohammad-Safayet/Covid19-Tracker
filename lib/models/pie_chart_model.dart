import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class LinearOccurance {
  final int no;
  final double occurance;
  final String str;
  final charts.Color arcColor;
  final int fontSize;

  LinearOccurance({
    @required this.str,
    @required this.no,
    @required this.occurance,
    @required this.arcColor,
    @required this.fontSize,
  });
}

class ListLinearOccurance {
  static List<LinearOccurance> data;

  static List<charts.Series<LinearOccurance, int>> dataBinding() {
    return [
      charts.Series<LinearOccurance, int>(
        id: 'Activity',
        data: data,
        outsideLabelStyleAccessorFn: (LinearOccurance activity, _) =>
            charts.TextStyleSpec(
          color: charts.ColorUtil.fromDartColor(
            Colors.white,
          ),
          fontFamily: "Oxanium",
          fontSize: activity.fontSize,
          lineHeight: 1.0,
        ),
        colorFn: (LinearOccurance activity, _) => activity.arcColor,
        domainFn: (LinearOccurance activity, _) => activity.no,
        measureFn: (LinearOccurance activity, _) => activity.occurance,
        labelAccessorFn: (LinearOccurance row, _) => '${row.occurance}%',
      ),
    ];
  }
}
