import 'package:flutter/material.dart';

import '../utils/constants.dart';
import '../models/continent.dart';
import './continent_country_tile.dart';

class ContinentCountryCard extends StatefulWidget {
  final List<ContinentCountry> items;
  final Continent continent;
  final Function func;

  const ContinentCountryCard({
    @required this.items,
    @required this.continent,
    this.func,
  });

  @override
  _ContinentCountryCardState createState() => _ContinentCountryCardState();
}

class _ContinentCountryCardState extends State<ContinentCountryCard> {
  bool _isOpen = false;
  final GlobalKey key = GlobalKey();

  void _expand() {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    setState(() {
      _isOpen = !_isOpen;
    });
    widget.func((!_isOpen) ? 0.0 : position.dy);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      key: key,
      duration: Duration(milliseconds: 750),
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: (!_isOpen) ? Color(0xFF1D1E33) : kBorderColor,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFF1D1E33),
        // color: Colors.pink,
      ),
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(milliseconds: 750),
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
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Countries",
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
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ...widget.items
                      .map(
                        (item) => ContinentContryTile(
                          name: item.name,
                          cases: item.cases,
                          deaths: item.deaths,
                          continentCases: widget.continent.totalCases,
                          continentDeaths: widget.continent.totalDeaths,
                        ),
                      )
                      .toList(),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
