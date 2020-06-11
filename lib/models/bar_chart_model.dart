import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import '../utils/constants.dart';

class ContinentChart {
  final String continent;
  final int number;


  ContinentChart({
    this.continent,
    this.number,
  });
}

class ListContinentChart {
  static List<ContinentChart> data = [];
  static Color color;

  static List<charts.Series<ContinentChart, String>> dataBinding() {
    return [
      new charts.Series<ContinentChart, String>(
        id: 'continent',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(color),
        domainFn: (ContinentChart occurence, _) => occurence.continent,
        measureFn: (ContinentChart occurance, _) => occurance.number,
        data: data,
        measureFormatterFn: (ContinentChart occurance, _) =>
        formatBarLabel,
        labelAccessorFn: (ContinentChart occurance, _) =>
             '${formatBarLabel(occurance.number)}',
      ),
    ];
  }
}
