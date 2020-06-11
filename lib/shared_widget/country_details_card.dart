import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../widgets/country_details.dart';

class CountryDetailsCard extends StatefulWidget {
  final List<List<dynamic>> items;
  final Function func;

  const CountryDetailsCard({
    Key key,
    @required this.items,
    this.func,
  }) : super(key: key);

  @override
  _CountryDetailsCardState createState() => _CountryDetailsCardState();
}

class _CountryDetailsCardState extends State<CountryDetailsCard> {
  bool _isOpen = false;
  var _controller = ScrollController();
  final GlobalKey key = GlobalKey();
  // double previousOffset;

  void _expand() {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);

    setState(() {
      (_isOpen)
          ? widget.func(0.0)
          : widget.func(position.dy);
      _isOpen = !_isOpen;
    });
  }

  // void _expand() {
  //   setState(() {
  //     (_isOpen) ? widget.func(0.0) : widget.func(position.dy + renderBox.size.height);
  //     _isOpen = !_isOpen;
  //   });
  //   if (_isOpen) previousOffset = _controller.offset;
  //   widget.func(_isOpen, previousOffset, 3, key);
  // }

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
      ),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Details",
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
            if (_isOpen)
              ListView(
                controller: _controller,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ...widget.items.map(
                    (item) {
                      return CountryDetails(
                        text: item.elementAt(0),
                        value: item.elementAt(1),
                      );
                    },
                  ).toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
