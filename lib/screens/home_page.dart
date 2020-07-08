import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/country_stats.dart';
import '../models/country.dart';
import '../models/province.dart';
import '../widgets/home_info_card.dart';
import '../widgets/home_line_chart_card.dart';
import '../providers/home_provider.dart';
import '../shared_widget/country_title.dart';
import '../shared_widget/country_overview_card.dart';
import '../shared_widget/country_details_card.dart';
import '../shared_widget/country_province_card.dart';
import '../utils/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var key = GlobalKey();
  ScrollController _scrollController = new ScrollController();
  var _refreshKey = GlobalKey<RefreshIndicatorState>();
  Country home;
  List<Province> provinces = [];
  CountryStats homeStats;

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
      var homeProvider = Provider.of<HomeProvider>(context, listen: false);
      
      await homeProvider.isHomeAvailable();
      if (!homeProvider.status) {
        await homeProvider.getWorldData();

        final snackBar = SnackBar(
          content: Text(
            'Please turn on the location',
            style: kHomeCardTextStyle.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 0.0,
            ),
          ),
        );

        Scaffold.of(context).showSnackBar(snackBar);
      } else {
        await homeProvider.getHomeData();
      }

      home = homeProvider.home;
      homeStats = homeProvider.stats;
      provinces = homeProvider.homeProvince;
    } catch (e) {}
  }

  void _func(
    double dy,
  ) {
    final RenderBox renderBox = key.currentContext.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);
    print((-position.dy - dy - _scrollController.offset).abs());

    _scrollController.animateTo(
      // (-position.dy - dy - _scrollController.offset).abs(),
      dy.abs() + _scrollController.offset,
      // dy.abs() - 50.0,
      curve: Curves.easeOutCubic,
      duration: const Duration(milliseconds: 1000),
    );
  }

  // void _func(bool isExpanded, double previousOffset, int index, GlobalKey myKey) {
  //   final keyContext = myKey.currentContext;

  //   if (keyContext != null) {
  //     // make sure that your widget is visible
  //     final box = keyContext.findRenderObject() as RenderBox;
  //     _scrollController.animateTo(isExpanded ? (box.size.height * index) : previousOffset,
  //         duration: Duration(milliseconds: 500), curve: Curves.linear);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<HomeProvider>(context);
    var padding = MediaQuery.of(context).padding;

    double height = MediaQuery.of(context).size.height -
        padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: _refresh,
        child: Container(
          child: (homeProvider.notifierState == NotifierState.Loading)
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(kBorderColor),
                  ),
                )
              : SingleChildScrollView(
                  controller: _scrollController,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: (homeProvider.notifierState == NotifierState.Failed)
                      ? Center(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  homeProvider.errMsg,
                                  style: kContinentCardTitleStyle,
                                ),
                              ),
                              RaisedButton(
                                onPressed: _refresh,
                                child: Text('Try Again'),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          key: key,
                          children: <Widget>[
                            CountryTitle(
                              countryName: home.name,
                              flag: home.flag,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            HomeInfoCard(
                              height: height * 0.50,
                              deaths: home.todayDeaths,
                              newCases: home.todayCases,
                              newRecovered: home.todayRecovered,
                            ),
                            CountryOverviewCard(
                              key: UniqueKey(),
                              func: _func,
                              height: height * 0.87,
                              active: home.active,
                              cases: home.cases,
                              deaths: home.deaths,
                              recovered: home.recovered,
                            ),
                            CountryDetailsCard(
                              key: UniqueKey(),
                              func: _func,
                              items: [
                                [
                                  'Total Cases',
                                  home.cases,
                                ],
                                [
                                  'Total Active',
                                  home.active,
                                ],
                                [
                                  'Total Deaths',
                                  home.deaths,
                                ],
                                [
                                  'Total Recovered',
                                  home.recovered,
                                ],
                                [
                                  'New Cases',
                                  home.todayCases,
                                ],
                                [
                                  'New Deaths',
                                  home.todayDeaths,
                                ],
                                [
                                  'New Recovered',
                                  home.todayRecovered,
                                ],
                                [
                                  'Case(s) Per Million',
                                  home.casesPerOneMillion,
                                ],
                                [
                                  'Death(s) Per Million',
                                  home.deathsPerOneMillion,
                                ],
                              ],
                            ),
                            if (homeStats != null)
                              HomeLineChartCard(
                                key: UniqueKey(),
                                height: height,
                                func: _func,
                                rawData: [
                                  homeStats.cases,
                                  homeStats.deaths,
                                  homeStats.recovered,
                                ],
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
    );
  }
}
