import 'package:flutter/foundation.dart';

class Country {
  final String name;
  final String flag;
  final String iso;
  final int cases;
  final int deaths;
  final int recovered;
  final int todayCases;
  final int todayDeaths;
  final int active;
  final dynamic casesPerOneMillion;
  final dynamic deathsPerOneMillion;
  final String continent;
  final int todayRecovered;

  Country({
    @required this.name,
    @required this.iso,
    @required this.flag,
    @required this.cases,
    @required this.deaths,
    @required this.recovered,
    @required this.todayCases,
    @required this.todayDeaths,
    @required this.todayRecovered,
    @required this.active,
    @required this.casesPerOneMillion,
    @required this.deathsPerOneMillion,
    @required this.continent,
  });

  factory Country.fromJSON(Map<String, dynamic> json) {
    return Country(
      iso: json['countryInfo']['iso3'] as String,
      name: json['country'] as String,
      flag: json['countryInfo']['flag'] as String,
      todayDeaths: json['todayDeaths'] as int ?? 0,
      active: json['active'] as int ?? 0,
      cases: json['cases'] as int ?? 0,
      casesPerOneMillion: json['casesPerOneMillion'] as dynamic ?? 0,
      deaths: json['deaths'] as int ?? 0,
      recovered: json['recovered'] as int ?? 0,
      todayCases: json['todayCases'] as int ?? 0,
      todayRecovered: json['todayRecovered'] as int ?? 0,
      deathsPerOneMillion: json['deathsPerOneMillion'] as dynamic ?? 0,
      continent: json['continent'] as String,
    );
  }

  factory Country.world(Map<String, dynamic> json) {
    return Country(
      name: 'World',
      iso: 'World',
      flag: 'assets/images/intFlag.png',
      todayDeaths: json['todayDeaths'] as int ?? 0,
      active: json['active'] as int ?? 0,
      cases: json['cases'] as int ?? 0,
      casesPerOneMillion: json['casesPerOneMillion'] as dynamic ?? 0,
      deaths: json['deaths'] as int ?? 0,
      recovered: json['recovered'] as int ?? 0,
      todayCases: json['todayCases'] as int ?? 0,
      todayRecovered: json['todayRecovered'] as int ?? 0,
      deathsPerOneMillion: json['deathsPerOneMillion'] as dynamic ?? 0,
      continent: '',
    );
  }
}
