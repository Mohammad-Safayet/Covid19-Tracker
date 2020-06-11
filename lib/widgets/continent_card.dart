import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CountinentCard extends StatelessWidget {
  final String name;
  final int totalCases;
  final int totalActive;
  final int totalDeaths;
  final int totalRecovered;
  final int countries;
  final double height;

  const CountinentCard({
    Key key,
    this.name,
    this.height,
    this.totalCases,
    this.totalActive,
    this.totalDeaths,
    this.totalRecovered,
    this.countries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFF1D1E33),
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFF1D1E33),
        // color: Colors.white10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(12.0),
            margin: const EdgeInsets.symmetric(horizontal: 25.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: kBorderColor,
                  style: BorderStyle.solid,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Container(
                    height: height * 0.2,
                    width: height * 0.2,
                    child: Image.asset(
                      (name.contains(' '))
                          ? 'assets/images/${name.split(' ')[0].toLowerCase()}.png'
                          : 'assets/images/${name.split('/')[0].toLowerCase()}.png',
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    name,
                    style: kCountryCardTitleStyle.copyWith(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Cases",
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      "Active",
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      "Deaths",
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      "Recovered",
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      "Contries",
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      formatNumber(
                        totalCases,
                      ),
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      formatNumber(
                        totalActive,
                      ),
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      formatNumber(
                        totalDeaths,
                      ),
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      formatNumber(
                        totalRecovered,
                      ),
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      countries.toString(),
                      style: kContinentCardTitleStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
