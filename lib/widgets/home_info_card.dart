import 'package:flutter/material.dart';

import '../utils/constants.dart';

class HomeInfoCard extends StatelessWidget {
  final int deaths;
  final int newCases;
  final double height;
  final int newRecovered;

  const HomeInfoCard({
    Key key,
    this.deaths,
    this.newRecovered,
    this.newCases,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: kBorderColor,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFF1D1E33),
        // color: Colors.white,
      ),
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Today\'s Overview',
              style: kHomeCardTextStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.045,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "New Cases",
                        style: kHomeCardTextStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '+' + formatNumber(newCases),
                        style: kHomeCardTextStyle.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height * 0.70,
                padding: const EdgeInsets.all(15.0),
                child: VerticalDivider(
                  color: Colors.white,
                  thickness: 1.0,
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "New Recovered",
                        style: kHomeCardTextStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 22.0,
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      child: Text(
                        '+' + formatNumber(newRecovered),
                        style: kHomeCardTextStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                          fontWeight: FontWeight.w800,
                          color: Colors.green[300],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "New Deaths",
                        style: kHomeCardTextStyle.copyWith(
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 22.0,
                        top: 8.0,
                        bottom: 8.0,
                      ),
                      child: Text(
                        '+' + formatNumber(deaths),
                        style: kHomeCardTextStyle.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.w800,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
