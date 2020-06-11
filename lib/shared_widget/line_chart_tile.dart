import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../models/line_chart_model.dart';
import '../widgets/country_line_charts.dart';

class LineChartTile extends StatelessWidget {
  final Function onPressed;
  final List<bool> isSelected;
  final double height;

  const LineChartTile({
    this.onPressed,
    this.isSelected,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: height,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ToggleButtons(
                borderColor: Colors.white,
                fillColor: kBorderColor,
                borderWidth: 2,
                selectedBorderColor: Colors.white,
                selectedColor: Colors.white,
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.03,
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Text(
                      'Cases',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontFamily: 'Oxanium',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.03,
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Text(
                      'Deaths',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontFamily: 'Oxanium',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.width * 0.03,
                      horizontal: MediaQuery.of(context).size.width * 0.04,
                    ),
                    child: Text(
                      'Recovered',
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.035,
                        fontFamily: 'Oxanium',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
                onPressed: onPressed,
                isSelected: isSelected,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10.0),
              height: height * 0.80,
              child: StatTimeSeriesChart(
                ListTimeStampOccurances.dataBinding('reason'),
                animate: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
