import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ContinentBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final double height;

  final simpleCurrencyFormatter =
      charts.BasicNumericTickFormatterSpec.fromNumberFormat(
    NumberFormat.compactCurrency(
      decimalDigits: 1,
      symbol: '',
    ),
  );

  ContinentBarChart(
    this.seriesList, {
    this.animate,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFF1D1E33),
      ),
      height: height,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: height * 0.05,
          ),
          Container(
            height: height * 0.85,
            child: charts.BarChart(
              this.seriesList,
              animate: true,
              
              barRendererDecorator: new charts.BarLabelDecorator(
                outsideLabelStyleSpec: charts.TextStyleSpec(
                  color: charts.MaterialPalette.white,
                ),
                insideLabelStyleSpec: charts.TextStyleSpec(
                  color: charts.MaterialPalette.black,
                ),
              ),
              domainAxis: charts.OrdinalAxisSpec(
                renderSpec: charts.SmallTickRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    fontSize: (MediaQuery.of(context).size.width * 0.03).toInt(),
                    fontFamily: 'JosefinSlab',
                    color: charts.MaterialPalette.white,
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.MaterialPalette.white,
                  ),
                ),
              ),
              // primaryMeasureAxis: new charts.NumericAxisSpec(
              //   renderSpec: new charts.NoneRenderSpec(),
              // ),
              primaryMeasureAxis: charts.NumericAxisSpec(
                showAxisLine: false,
                tickFormatterSpec: simpleCurrencyFormatter,
                renderSpec: charts.GridlineRendererSpec(
                  labelStyle: charts.TextStyleSpec(
                    fontSize: (MediaQuery.of(context).size.width * 0.03).toInt(),
                    fontFamily: 'Oxanium',
                    color: charts.MaterialPalette.white,
                  ),
                  lineStyle: charts.LineStyleSpec(
                    color: charts.MaterialPalette.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
