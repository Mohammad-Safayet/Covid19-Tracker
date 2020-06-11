import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import '../models/line_chart_model.dart';
import '../utils/constants.dart';
import '../shared_widget/line_chart_tile.dart';

class HomeLineChartCard extends StatefulWidget {
  final List<Map<String, dynamic>> rawData;
  final Function func;
  final double height;

  const HomeLineChartCard({
    Key key,
    this.func,
    @required this.rawData,
    this.height,
  });

  @override
  _HomeLineChartCardState createState() => _HomeLineChartCardState();
}

class _HomeLineChartCardState extends State<HomeLineChartCard> {
  final inputFormat = DateFormat("MM/dd/yyyy");
  bool _isOpen = false;
  List<bool> _isSelected = [
    true,
    false,
    false,
  ];
  var _controller = ScrollController();
  final GlobalKey key = GlobalKey();
  // double previousOffset;

  void _expand() {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);

    setState(() {
      (_isOpen)
          ? widget.func(0.0)
          : widget.func(position.dy + widget.height);
      _isOpen = !_isOpen;
    });
  }

  // void _expand() {
  //   setState(() {
  //     // (_isOpen) ? widget.func(0.0) : widget.func(position.dy + renderBox.size.height);
  //     _isOpen = !_isOpen;
  //   });
  //   if (_isOpen) previousOffset = _controller.offset;
  //   widget.func(_isOpen, previousOffset, 3, key);
  // }

  @override
  void initState() {
    super.initState();

    _process(0);
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  void _process(int index) {
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
      _process(index);
      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == index;
      }
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
    return GestureDetector(
      onTap: _expand,
      child: AnimatedContainer(
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
        height: (_isOpen) ? widget.height : widget.height * 0.12,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            key: key,
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
                      height: widget.height * 0.80,
                      isSelected: _isSelected,
                      onPressed: _onPressed,
                    ),
                  ],
          ),
        ),
      ),
    );
  }
}
