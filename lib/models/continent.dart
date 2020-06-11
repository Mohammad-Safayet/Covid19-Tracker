import 'package:flutter/foundation.dart';

class Continent {
  final String name;
  int totalCases;
  int totalDeaths;
  int totlaRecovered;
  int totalActive;

  Continent({
    @required this.name,
    @required this.totalCases,
    @required this.totalDeaths,
    @required this.totlaRecovered,
    @required this.totalActive,
  });
}

class ContinentCountry {
  final String name;
  final int cases;
  final int deaths;

  ContinentCountry({
    @required this.name,
    @required this.cases,
    @required this.deaths,
  });

  factory ContinentCountry.fromJSON(Map<String, dynamic> json) {
    return ContinentCountry(
      name: json['name'] as String,
      cases: json['cases'] as int ?? 0,
      deaths: json['deaths'] as int ?? 0,
    );
  }
}
