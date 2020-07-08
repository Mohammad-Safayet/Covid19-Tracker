import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;

import '../widgets/country_dougnut_chart.dart';
import '../models/pie_chart_model.dart';
import '../utils/constants.dart';

class CountryOverviewCard extends StatefulWidget {
  final int cases;
  final int recovered;
  final int active;
  final int deaths;
  final double height;
  final Function func;

  const CountryOverviewCard({
    this.cases,
    this.recovered,
    this.active,
    this.deaths,
    this.func,
    this.height,
    Key key,
  }) : super(key: key);

  @override
  _CountryOverviewCardState createState() => _CountryOverviewCardState();
}

class _CountryOverviewCardState extends State<CountryOverviewCard> {
  bool _isOpen = false;
  final GlobalKey key = GlobalKey();

  void _expand() {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);

    setState(() {
      (_isOpen) ? widget.func(0.0) : widget.func(position.dy);
      _isOpen = !_isOpen;
    });
  }

  List<Widget> _list() {
    return [
      SizedBox(
        height: 20.0,
      ),
      Flexible(
        flex: (_isOpen) ? 2 : 0,
        child: Container(
          height: (_isOpen) ? widget.height * 0.12 : 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                'Active\n\n\t' + formatNumber(widget.active),
                style: kHomeCardTextStyle.copyWith(
                  fontSize: widget.height * 0.03,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Deaths\n\n\t' + formatNumber(widget.deaths),
                style: kHomeCardTextStyle.copyWith(
                  fontSize: widget.height * 0.03,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'Recovered\n\n\t' + formatNumber(widget.recovered),
                style: kHomeCardTextStyle.copyWith(
                  fontSize: widget.height * 0.03,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
      Flexible(
        flex: (_isOpen) ? 5 : 0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50.0),
          child: OverviewDougnutChart(
            ListLinearOccurance.dataBinding(),
            (_isOpen) ? widget.height * 0.58 : 0,
            animate: false,
          ),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    ListLinearOccurance.data = [
      if (widget.deaths != 0)
        LinearOccurance(
            no: 2,
            occurance: double.parse(
              ((widget.deaths / widget.cases) * 100).toStringAsFixed(1),
            ),
            str: "Deaths",
            arcColor: charts.ColorUtil.fromDartColor(
              Colors.red[800],
            ),
            fontSize: (MediaQuery.of(context).size.width * 0.037).floor()),
      if (widget.active != 0)
        LinearOccurance(
            no: 0,
            occurance: double.parse(
              ((widget.active / widget.cases) * 100).toStringAsFixed(1),
            ),
            str: "Active",
            arcColor: charts.ColorUtil.fromDartColor(
              Color(0xFFFFB166),
            ),
            fontSize: (MediaQuery.of(context).size.width * 0.037).floor()),
      if (widget.recovered != 0)
        LinearOccurance(
            no: 12,
            occurance: double.parse(
              ((widget.recovered / widget.cases) * 100).toStringAsFixed(1),
            ),
            str: 'Recovered',
            arcColor: charts.ColorUtil.fromDartColor(
              Colors.green[800],
            ),
            fontSize: (MediaQuery.of(context).size.width * 0.037).floor()),
    ];

    return AnimatedContainer(
      duration: Duration(milliseconds: 550),
      curve: Curves.bounceInOut,
      margin: const EdgeInsets.all(10.0),
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: (!_isOpen) ? Color(0xFF1D1E33) : kBorderColor,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFF1D1E33),
        // color: Colors.white,
      ),
      height: (_isOpen) ? widget.height : 60.0,
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 550),
              margin: (_isOpen)
                  ? const EdgeInsets.all(12.0)
                  : const EdgeInsets.all(0.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: (!_isOpen) ? Color(0xFF1D1E33) : kBorderColor,
                    style: BorderStyle.solid,
                  ),
                ),
                color: Color(0xFF1D1E33),
              ),
              // height: (_isOpen) ? widget.height : widget.height * 0.10,
              child: Row(
                key: key,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Overview',
                      style: kCountryCardTitleStyle,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      (_isOpen)
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: Colors.white,
                      size: 30.0,
                    ),
                    onPressed: _expand,
                  ),
                ],
              ),
            ),
            if (_isOpen) ..._list(),
          ],
        ),
      ),
    );
  }
}
