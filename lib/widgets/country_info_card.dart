import 'package:flutter/material.dart';

import './country_info_formtion.dart';
import '../utils/constants.dart';

class CountryInfoCard extends StatelessWidget {
  final int cases;
  final int deaths;
  final int recovered;

  const CountryInfoCard({
    Key key,
    this.cases,
    this.deaths,
    this.recovered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        border: Border.all(
          color:  kBorderColor,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(12.0),
        color: Color(0xFF1D1E33),
        // color: Colors.white,
      ),
      height: MediaQuery.of(context).size.height * 0.30,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          CountryInfoFormation(
            text: 'Total Cases ',
            data: cases,
          ),
          CountryInfoFormation(
            text: 'Total deaths ',
            data: deaths,
          ),
          CountryInfoFormation(
            text: 'Total Recovered ',
            data: recovered,
          ),
        ],
      ),
    );
  }
}
