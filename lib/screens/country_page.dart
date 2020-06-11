import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/country.dart';
import '../models/province.dart';
import '../models/country_stats.dart';
import '../widgets/country_stat_card.dart';
import '../widgets/covid_app_bar.dart';
import '../shared_widget/country_details_card.dart';
import '../shared_widget/country_overview_card.dart';
import '../shared_widget/country_title.dart';
import '../widgets/country_info_card.dart';
import '../shared_widget/country_province_card.dart';
import '../providers/country_provider.dart';
import '../utils/constants.dart';

class CountryPage extends StatefulWidget {
  final String countryName;

  const CountryPage({
    Key key,
    this.countryName,
  }) : super(key: key);

  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {
  var _refreshKey = GlobalKey<RefreshIndicatorState>();
  Country country;
  List<Province> provinces = [];
  CountryStats stats;
  var rawData;
  bool _pageNotFound = false;
  var key = GlobalKey();
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _refresh();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  Future<Null> _refresh() async {
    try {
      _refreshKey.currentState?.show(atTop: false);
      var countryProvider =
          Provider.of<CountryProvider>(context, listen: false);

      if (widget.countryName == 'World') {
        await countryProvider.getWorld();
      } else {
        await countryProvider.getTheCountry(widget.countryName);
      }

      country = countryProvider.country;
      stats = countryProvider.timeline;
      if (stats != null)
        rawData = [
          stats.cases,
          stats.deaths,
          stats.recovered,
        ];

      provinces = countryProvider.countryProvince;
    } catch (e) {
      _pageNotFound = true;
    }
  }

  void _func(
    double dy,
  ) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    print((-position.dy - dy - _scrollController.offset).abs());

    _scrollController.animateTo(
      (-position.dy - dy - _scrollController.offset).abs(),
      // dy.abs() - position.dy,
      // dy.abs() - 50.0,
      curve: Curves.easeOutCubic,
      duration: const Duration(milliseconds: 1500),
    );
  }

  @override
  Widget build(BuildContext context) {
    var countryProvider = Provider.of<CountryProvider>(context);
    var padding = MediaQuery.of(context).padding;

    double height = MediaQuery.of(context).size.height -
        padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;

    return SafeArea(
      child: Scaffold(
        appBar: CovidAppBar(
          title: widget.countryName,
          appBarWidget: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 32.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: (countryProvider.countryNotifierState == NotifierState.Loading)
              ? Container(
                  height: height,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kBorderColor),
                    ),
                  ),
                )
              : SingleChildScrollView(
                  key: key,
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: (countryProvider.countryNotifierState ==
                          NotifierState.NotFound)
                      ? Text(
                          "Page not found",
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            children: <Widget>[
                              CountryTitle(
                                countryName: country.name,
                                flag: country.flag,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              CountryInfoCard(
                                cases: country.cases,
                                deaths: country.deaths,
                                recovered: country.recovered,
                              ),
                              CountryOverviewCard(
                                height: height * 0.87,
                                func: _func,
                                active: country.active,
                                cases: country.cases,
                                deaths: country.deaths,
                                recovered: country.recovered,
                              ),
                              CountryDetailsCard(
                                key: UniqueKey(),
                                func: _func,
                                items: [
                                  [
                                    'Total Cases',
                                    country.cases,
                                  ],
                                  [
                                    'Total Active',
                                    country.active,
                                  ],
                                  [
                                    'Total Deaths',
                                    country.deaths,
                                  ],
                                  [
                                    'Total Recovered',
                                    country.recovered,
                                  ],
                                  [
                                    'New Cases',
                                    country.todayCases,
                                  ],
                                  [
                                    'New Deaths',
                                    country.todayDeaths,
                                  ],
                                  [
                                    'New Recovered',
                                    country.todayRecovered,
                                  ],
                                  [
                                    'Case(s) Per Million',
                                    country.casesPerOneMillion,
                                  ],
                                  [
                                    'Death(s) Per Million',
                                    country.deathsPerOneMillion,
                                  ],
                                ],
                              ),
                              if (stats != null)
                                CountryStatCard(
                                  key: UniqueKey(),
                                  height: height * 0.80,
                                  func: _func,
                                  rawData: rawData,
                                ),
                              if (provinces.length > 0)
                                CountryProvinceCard(
                                  key: UniqueKey(),
                                  func: _func,
                                  provinces: provinces,
                                ),
                            ],
                          ),
                        ),
                ),
        ),
      ),
    );
  }
}
