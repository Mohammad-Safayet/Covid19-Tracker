import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../models/continent.dart';
import '../providers/continent_provider.dart';
import '../widgets/covid_app_bar.dart';
import '../widgets/continent_country.dart';
import '../widgets/continent_card.dart';
import '../utils/constants.dart';

class ContinentPage extends StatefulWidget {
  final String continentName;

  const ContinentPage({
    Key key,
    this.continentName,
  }) : super(key: key);

  @override
  _ContinentPageState createState() => _ContinentPageState();
}

class _ContinentPageState extends State<ContinentPage> {
  bool _isLoading = false;
  bool _pageNotFound;
  bool _isOpen = false;
  Continent _continent;
  List<ContinentCountry> _list = [];
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _refresh();
  }

  Future<Null> _refresh() async {
    try {
      await Provider.of<ContinentProvider>(context, listen: false)
          .getContinent(widget.continentName);

      _list = Provider.of<ContinentProvider>(context, listen: false).list;
      _continent =
          Provider.of<ContinentProvider>(context, listen: false).continent;
    } catch (_) {
      _pageNotFound = true;
      print(_);
    }
  }

  void _func(double dy) {
    _controller.animateTo(
      dy,
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeOutQuart,
    );
    setState(() {
      _isOpen = !_isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    var continentProvider = Provider.of<ContinentProvider>(context);
    var padding = MediaQuery.of(context).padding;

    double height =
        MediaQuery.of(context).size.height - padding.top - kToolbarHeight;

    print(widget.continentName);
    return SafeArea(
      child: Scaffold(
        appBar: CovidAppBar(
          title: widget.continentName,
          appBarWidget: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 32.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Container(
          height: height,
          child: (continentProvider.notifierState == NotifierState.Loading)
              ? Center(
                child: CircularProgressIndicator(
                    valueColor:  AlwaysStoppedAnimation<Color>(kBorderColor),
                  ),
              )
              : SingleChildScrollView(
                  controller: _controller,
                  physics: AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      CountinentCard(
                        height: height * 0.75,
                        name: _continent.name,
                        totalCases: _continent.totalCases,
                        totalActive: _continent.totalActive,
                        totalDeaths: _continent.totalDeaths,
                        totalRecovered: _continent.totlaRecovered,
                        countries: _list.length,
                      ),
                      ContinentCountryCard(
                        continent: _continent,
                        items: _list,
                        func: _func,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
