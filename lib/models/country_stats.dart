import 'package:flutter/foundation.dart';

class CountryStats {
  final String name;
  final List<dynamic> provinces;
  final Map<String, dynamic> cases;
  final Map<String, dynamic> deaths;
  final Map<String, dynamic> recovered;

  CountryStats({
    @required this.name,
    @required this.provinces,
    @required this.cases,
    @required this.deaths,
    @required this.recovered,
  });

  factory CountryStats.fromJSON(Map<String, dynamic> json) {
    return CountryStats(
      name: json['country'] as String,
      provinces: json['provinces'] as List<dynamic>,
      cases: json['timeline']['cases'] as Map<String, dynamic>,
      deaths: json['timeline']['deaths'] as Map<String, dynamic>,
      recovered: json['timeline']['recovered'] as Map<String, dynamic>,
    );
  }
  
  factory CountryStats.world(Map<String, dynamic> json) {
    return CountryStats(
      name: 'Worl',
      provinces: [],
      cases: json['cases'] as Map<String, dynamic>,
      deaths: json['deaths'] as Map<String, dynamic>,
      recovered: json['recovered'] as Map<String, dynamic>,
    );
  }
}
