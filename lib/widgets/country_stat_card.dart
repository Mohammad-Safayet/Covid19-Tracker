import 'package:covidsimulation/utils/constants.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/line_chart_model.dart';
import '../shared_widget/line_chart_tile.dart';

class CountryStatCard extends StatefulWidget {
  final rawData;
  final Function func;
  final double height;

  const CountryStatCard({
    Key key,
    this.rawData,
    this.func,
    this.height,
  }) : super(key: key);

  @override
  _CountryStatCardState createState() => _CountryStatCardState();
}

class _CountryStatCardState extends State<CountryStatCard> {
  final inputFormat = DateFormat("MM/dd/yyyy");
  var rawData;
  var stats;
  bool _isLoading = false;
  bool _isOpen = false;
  List<bool> _isSelected = [
    true,
    false,
    false,
  ];
  var _controller = ScrollController();
  final GlobalKey key = GlobalKey();
  var value;

  void _expand() {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    print('height:' + renderBox.size.height.toString());

    setState(() {
      (_isOpen)
          ? widget.func(0.0)
          : widget.func(
              position.dy.abs() + renderBox.size.height,
            );
      _isOpen = !_isOpen;
    });
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() {
    setState(() {
      _isLoading = !_isLoading;
    });
    _process(0);

    setState(() {
      _isLoading = !_isLoading;
    });
  }

  void _process(int index) async {
    ListTimeStampOccurances.data = [];
    if (index == 1) {
      ListTimeStampOccurances.color = Colors.red;
    } else if (index == 2) {
      ListTimeStampOccurances.color = Colors.green;
    } else {
      ListTimeStampOccurances.color = Colors.white;
    }

    widget.rawData.elementAt(index).forEach(
      (String key, dynamic value) {
        ListTimeStampOccurances.data.add(
          TimeSeriesOccurance(
            time: inputFormat.parse(key),
            occurances: value,
          ),
        );
      },
    );
  }

  void _onPressed(int index) {
    setState(() {
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == index;
      }
      _process(index);
    });
  }

  Widget _title() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 550),
      margin:
          (_isOpen) ? const EdgeInsets.all(12.0) : const EdgeInsets.all(0.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: (!_isOpen) ? Color(0xFF1D1E33) : kBorderColor,
            style: BorderStyle.solid,
          ),
        ),
        color: Color(0xFF1D1E33),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Statistics',
              style: kCountryCardTitleStyle,
            ),
          ),
          IconButton(
            icon: Icon(
              (_isOpen) ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: _expand,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: key,
      duration: Duration(milliseconds: 550),
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: (!_isOpen) ? Color(0xFF1D1E33) : kBorderColor,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFF1D1E33),
        // color: Colors.white,
      ),
      height: (_isOpen)
          ? MediaQuery.of(context).size.height * 0.85
          : MediaQuery.of(context).size.height * 0.09,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: (!_isOpen)
              ? [
                  _title(),
                ]
              : [
                  _title(),
                  SizedBox(
                    height: 20.0,
                  ),
                  LineChartTile(
                    height: widget.height * 0.90,
                    isSelected: _isSelected,
                    onPressed: _onPressed,
                  ),
                ],
        ),
      ),
    );
  }
}
