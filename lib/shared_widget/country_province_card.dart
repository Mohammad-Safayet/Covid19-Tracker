import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../models/province.dart';
import '../widgets/province_tile.dart';

class CountryProvinceCard extends StatefulWidget {
  final List<Province> provinces;
  final Function func;

  const CountryProvinceCard({
    Key key,
    this.func,
    this.provinces,
  }) : super(key: key);

  @override
  _CountryProvinceCardState createState() => _CountryProvinceCardState();
}

class _CountryProvinceCardState extends State<CountryProvinceCard> {
  bool _isOpen = false;
  final GlobalKey key = GlobalKey();
  final _controller = ScrollController();
  // double previousOffset;

  void _expand() {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);

    setState(() {
      (_isOpen)
          ? widget.func(0.0)
          : widget.func(position.dy.abs());
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
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: key,
      duration: Duration(milliseconds: 150),
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
                      "Province(s)",
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
                physics: PageScrollPhysics(),
                shrinkWrap: true,
                children: [
                  ...widget.provinces.map(
                    (province) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10.0),
                          child: ProvinceTile(
                            name: province.name,
                            confirmed: province.cases,
                            deaths: province.deaths,
                            recovered: province.recovered,
                          ),
                        ),
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
