import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../widgets/world_dropdownmenu.dart';
import '../widgets/world_card.dart';
import '../widgets/search_bar.dart';
import '../providers/country_provider.dart';
import '../utils/constants.dart';

class WorldPage extends StatefulWidget {
  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> {
  var _refreshKey = GlobalKey<RefreshIndicatorState>();
  List countries = [];
  String state;
  final textEditingController = TextEditingController();
  bool _errorOccured = false;
  final _controller = ScrollController();
  String _errMsg;

  @override
  void initState() {
    super.initState();
    _refresh('country');
  }

  @override
  void dispose() {
    textEditingController.dispose();
    _controller.dispose();

    super.dispose();
  }

  Future<Null> _refresh(String state) async {
    // try {
    _refreshKey.currentState?.show(atTop: false);
    textEditingController.text = '';

    state =
        Provider.of<CountryProvider>(context, listen: false).state ?? 'country';
    await Provider.of<CountryProvider>(context, listen: false)
        .getTheCountries(state);
    // } catch (e) {
    //   _errorOccured = true;
    //   _errMsg = e.toString();
    // }
  }

  @override
  Widget build(BuildContext context) {
    state = Provider.of<CountryProvider>(context).state;
    double width = MediaQuery.of(context).size.width;
    var padding = MediaQuery.of(context).padding;

    double height = MediaQuery.of(context).size.height -
        padding.top -
        kToolbarHeight -
        kBottomNavigationBarHeight;

    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: () => _refresh(state),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        // onPanStart: (_) {
        //   _refresh(state);
        // },
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Consumer<CountryProvider>(
          builder: (context, countryProvider, _) {
            return Container(
              height: height,
              width: width,
              child: Column(
                children: <Widget>[
                  SearchBar(
                    height: height * 0.12,
                    controller: textEditingController,
                    filter: () =>
                        countryProvider.filter(textEditingController.text),
                  ),
                  Container(
                    height: 25.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          'Sort By: ',
                          style: kPopUpMenuItemStyle.copyWith(
                            letterSpacing: 0,
                          ),
                        ),
                        CovidDropDownMenu(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: (countryProvider.countriesNotifierState ==
                              NotifierState.Loading)
                          ? Center(
                              child: CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(kBorderColor),
                              ),
                            )
                          : (countryProvider.countriesNotifierState ==
                                  NotifierState.Failed)
                              ? Center(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Text(
                                          countryProvider.errMsg,
                                          style: kContinentCardTitleStyle,
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: () => _refresh(state),
                                        child: Text('Try Again'),
                                      ),
                                    ],
                                  ),
                                )
                              : (countryProvider.countriesNotifierState ==
                                      NotifierState.NotFound)
                                  ? Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Center(
                                        child: Text(
                                          'Not Founnd!',
                                          style: kCountryCardTitleStyle,
                                        ),
                                      ),
                                    )
                                  : Scrollbar(
                                      child: ListView.builder(
                                        key: PageStorageKey('myListView'),
                                        controller: _controller,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        itemCount: countryProvider
                                            .filteredCountries.length,
                                        itemBuilder: (context, index) {
                                          String text;
                                          int value;

                                          if (state == 'cases') {
                                            text = 'Total Cases';
                                            value = countryProvider
                                                .filteredCountries[index].cases;
                                          } else if (state ==
                                              'todayRecovered') {
                                            text = 'New Recovered';
                                            value = countryProvider
                                                .filteredCountries[index]
                                                .todayRecovered;
                                          } else if (state == 'todayDeaths') {
                                            text = 'New Deaths';
                                            value = countryProvider
                                                .filteredCountries[index]
                                                .todayDeaths;
                                          } else if (state == 'active') {
                                            text = 'Active Cases';
                                            value = countryProvider
                                                .filteredCountries[index]
                                                .active;
                                          } else if (state == 'deaths') {
                                            text = 'Total Deaths';
                                            value = countryProvider
                                                .filteredCountries[index]
                                                .deaths;
                                          } else if (state == 'recovered') {
                                            text = 'Recovered';
                                            value = countryProvider
                                                .filteredCountries[index]
                                                .recovered;
                                          } else if (state == 'country') {
                                            text = 'Total Cases';
                                            value = countryProvider
                                                .filteredCountries[index].cases;
                                          } else {
                                            text = 'New Cases';
                                            value = countryProvider
                                                .filteredCountries[index]
                                                .todayCases;
                                          }

                                          return CovidCard(
                                            iso: countryProvider
                                                    .filteredCountries[index]
                                                    .iso ??
                                                countryProvider
                                                    .filteredCountries[index]
                                                    .name,
                                            name: countryProvider
                                                .filteredCountries[index].name,
                                            flag: countryProvider
                                                .filteredCountries[index].flag,
                                            value: value,
                                            text: text,
                                          );
                                        },
                                      ),
                                    ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
