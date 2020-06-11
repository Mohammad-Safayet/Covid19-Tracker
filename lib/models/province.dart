import 'package:flutter/foundation.dart';

class Province {
  final String name;
  final String country;
  final int cases;
  final int deaths;
  final int recovered;

  Province({
    @required this.name,
    @required this.country,
    @required this.cases,
    @required this.deaths,
    @required this.recovered,
  });

  factory Province.fromJSON(Map<String, dynamic> json) {
    return Province(
      name: json['province'] as String,
      country: json['country'] as String,
      cases: json['stats']['confirmed'] as int ?? 0,
      deaths: json['stats']['deaths'] as int ?? 0,
      recovered: json['stats']['recovered'] as int ?? 0,
    );
  }
}
