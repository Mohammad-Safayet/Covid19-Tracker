import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

class OverviewDougnutChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final double height;

  OverviewDougnutChart(
    this.seriesList,
    this.height, {
    this.animate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: charts.PieChart(
        seriesList,
        animate: animate,
        layoutConfig: charts.LayoutConfig(
          bottomMarginSpec: charts.MarginSpec.fixedPixel(10),
          topMarginSpec: charts.MarginSpec.fixedPixel(10),
          rightMarginSpec: charts.MarginSpec.fixedPixel(10),
          leftMarginSpec: charts.MarginSpec.fixedPixel(10),
        ),
        defaultRenderer: charts.ArcRendererConfig(
          arcWidth: 55,
          startAngle: 145,
          strokeWidthPx: 0,
          arcRendererDecorators: [
            charts.ArcLabelDecorator(
              labelPadding: 1,
              labelPosition: charts.ArcLabelPosition.outside,
              leaderLineStyleSpec: charts.ArcLabelLeaderLineStyleSpec(
                length: 10.0,
                thickness: 1.0,
                color: charts.MaterialPalette.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
