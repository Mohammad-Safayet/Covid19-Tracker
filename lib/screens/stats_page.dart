import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../providers/continent_provider.dart';
import '../models/continent.dart';
import '../models/bar_chart_model.dart';
import '../utils/constants.dart';
import '../widgets/continent_bar_chart.dart';
import '../widgets/continent_tile.dart';

class ContinentStatPage extends StatefulWidget {
  @override
  _ContinentStatPageState createState() => _ContinentStatPageState();
}

class _ContinentStatPageState extends State<ContinentStatPage> {
  bool run = false;
  final _controller = ScrollController();
  List<Continent> _world;
  List<Continent> _sortedWorld;
  List<bool> _isSelected = [
    true,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    if (!run) _getData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (run) {
      _getData();
      run = true;
    }
  }

  Future<Null> _getData() async {
    try {
      _isSelected = [true, false, false];

      await Provider.of<ContinentProvider>(context, listen: false).getData();
      _world = Provider.of<ContinentProvider>(context, listen: false).world;

      _process(0);
    } catch (e) {
      print(e);
    }
  }

  void _process(int index) async {
    ListContinentChart.data = [];
    if (index == 1) {
      _sortedWorld =
          Provider.of<ContinentProvider>(context, listen: false).sort(1);
      ListContinentChart.color = Colors.red;
    } else if (index == 2) {
      _sortedWorld =
          Provider.of<ContinentProvider>(context, listen: false).sort(2);
      ListContinentChart.color = Colors.green;
    } else {
      _sortedWorld =
          Provider.of<ContinentProvider>(context, listen: false).sort(0);
      ListContinentChart.color = Colors.orange[100];
    }

    // _sortedWorld = Provider.of<ContinentProvider>(context, listen: false).world;
    _world.forEach(
      (continent) {
        int value;
        if (index == 0) {
          value = continent.totalCases;
        } else if (index == 1) {
          value = continent.totalDeaths;
        } else {
          value = continent.totlaRecovered;
        }
        ListContinentChart.data.add(
          ContinentChart(
            continent: formatBarTitle(continent.name),
            number: value,
          ),
        );
      },
    );
  }

  void _onPressed(int index) {
    setState(() {
      _controller.animateTo(
        0.0,
        duration: Duration(
          milliseconds: 550,
        ),
        curve: Curves.easeIn,
      );

      for (int i = 0; i < _isSelected.length; i++) {
        _isSelected[i] = i == index;
      }
      _process(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    var stat = Provider.of<ContinentProvider>(context);
    var padding = MediaQuery.of(context).padding;

    double height = MediaQuery.of(context).size.height -
        padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;

    return Container(
      child: (stat.notifierState == NotifierState.Loading)
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(kBorderColor),
              ),
            )
          : (stat.notifierState == NotifierState.Failed)
              ? Center(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          stat.errMsg,
                          style: kContinentCardTitleStyle,
                        ),
                      ),
                      RaisedButton(
                        onPressed: _getData,
                        child: Text('Try Again'),
                      ),
                    ],
                  ),
                )
              : Container(
                  height: height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    fit: StackFit.expand,
                    alignment: Alignment.bottomCenter,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: SingleChildScrollView(
                          controller: _controller,
                          child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: height * 0.15,
                              ),
                              ContinentBarChart(
                                ListContinentChart.dataBinding(),
                                height: height * 0.80,
                              ),
                              Padding(
                                padding: EdgeInsets.all(height * 0.03),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: new Container(
                                        margin:
                                            const EdgeInsets.only(right: 10.0),
                                        child: Divider(
                                          color: kBorderColor,
                                          height: 46,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      'Continents',
                                      style: kCountryCardTitleStyle,
                                    ),
                                    Expanded(
                                      child: new Container(
                                        margin:
                                            const EdgeInsets.only(left: 10.0),
                                        child: Divider(
                                          color: kBorderColor,
                                          height: 36,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: height * 0.45,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.all(8.0),
                                  shrinkWrap: true,
                                  children: [
                                    ..._sortedWorld
                                        .map(
                                          (continent) => ContinentTile(
                                            height: height * 0.5,
                                            name: continent.name,
                                            confirmed: continent.totalCases,
                                            deaths: continent.totalDeaths,
                                            recovered: continent.totlaRecovered,
                                          ),
                                        )
                                        .toList(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          margin: const EdgeInsets.all(8.0),
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
                                  vertical:
                                      MediaQuery.of(context).size.width * 0.03,
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                child: Text(
                                  'Cases',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                    fontFamily: 'Oxanium',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.width * 0.03,
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                child: Text(
                                  'Deaths',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                    fontFamily: 'Oxanium',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.width * 0.03,
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.04,
                                ),
                                child: Text(
                                  'Recovered',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                    fontFamily: 'Oxanium',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            onPressed: _onPressed,
                            isSelected: _isSelected,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
