import 'dart:io';
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart';

import '../services/https.dart';
import '../models/country.dart';
import '../models/country_stats.dart';
import '../models/province.dart';

enum NotifierState {
  Loading,
  Loaded,
  Failed,
  NotFound,
}

class CountryProvider with ChangeNotifier {
  NotifierState countriesNotifierState;
  NotifierState countryNotifierState;

  List<Country> _countries;
  List<Country> _filteredCountries;

  Country _country;
  CountryStats _stats;
  List<Province> _countryProvince;

  String state;
  String errMsg;
  final Https https = Https();

  void filter(String text) {
    _filteredCountries = countries.where(
      (country) {
        return country.name.toLowerCase().contains(text.toLowerCase());
      },
    ).toList();

    if (_filteredCountries.length == 0 && _countries.length != 0)
      countriesNotifierState = NotifierState.NotFound;
    else
      countriesNotifierState = NotifierState.Loaded;
    notifyListeners();
  }

  void _setErrorMsg(String str) {
    errMsg = str;
  }

  Future<void> getWorld() async {
    try {
      _setCountryData(null, null, null);
      countryNotifierState = NotifierState.Loading;

      // Country fetching
      var response = await https.client.get(https.worldUri.toString());
      var country = jsonDecode(response.body);

      // stats fetching
      var response1 = await https.client.get(
        https.statUri.toString() + '/all',
      );
      var stats;

      if (response1.statusCode != 200) {
        stats = null;
      } else {
        stats = jsonDecode(response1.body);
      }

      _setCountryData(
        Country.world(country),
        (stats != null) ? CountryStats.world(stats) : null,
        [],
      );

      countryNotifierState = NotifierState.Loaded;
      notifyListeners();
    } on SocketException {
      _setErrorMsg("No Internet Connection");
      countriesNotifierState = NotifierState.Failed;

      notifyListeners();
    } on ClientException {
      _setErrorMsg("Server Problem");
      countriesNotifierState = NotifierState.Failed;

      notifyListeners();
    } catch (e) {
      print(e);
      _setErrorMsg("Connection Problem");
      countriesNotifierState = NotifierState.Failed;

      notifyListeners();
    }
  }

  // All countries Setter
  void _setCountries(List<Country> countries) {
    _countries = countries;
    _filteredCountries = [..._countries];
  }

  Future<void> getTheCountries(String value) async {
    try {
      state = value;
      var response;

      countriesNotifierState = NotifierState.Loading;

      var worldResponse = await https.client.get(https.worldUri.toString());
      var worldBody = Country.world(jsonDecode(worldResponse.body));
      // temp.add(Country.world(worldBody));

      if (value == 'country') {
        response = await https.client.get(https.countryUri.toString());
      } else {
        response = await https.client
            .get(https.countryUri.toString() + '?sort=$value');
      }

      List<dynamic> body = jsonDecode(response.body);
      var tempBody = body.map(
        (dynamic data) {
          return Country.fromJSON(data);
        },
      ).toList();

      _setCountries([worldBody, ...tempBody]);

      countriesNotifierState = NotifierState.Loaded;
      notifyListeners();
    } on SocketException {
      _setErrorMsg("No Internet Connection");
      countriesNotifierState = NotifierState.Failed;

      notifyListeners();
    } on ClientException {
      _setErrorMsg("Server Problem");
      countriesNotifierState = NotifierState.Failed;

      notifyListeners();
    } catch (e) {
      print(e);
      _setErrorMsg("Connection Problem");
      countriesNotifierState = NotifierState.Failed;

      notifyListeners();
    }
  }

  // Single country getter
  void _setCountryData(
    Country country,
    CountryStats stats,
    List<Province> province,
  ) {
    _country = country;
    _stats = stats;
    _countryProvince = province;
  }

  Future<void> getTheCountry(String countryName) async {
    try {
      _setCountryData(null, null, null);
      countryNotifierState = NotifierState.Loading;

      // Country fetching
      var response =
          await https.client.get(https.countryUri.toString() + '/$countryName');

      var country = jsonDecode(response.body);

      // stats fetching
      var response1 = await https.client.get(
        https.statUri.toString() + '/$countryName',
      );
      var stats;

      if (response1.statusCode != 200) {
        stats = null;
      } else {
        stats = jsonDecode(response1.body);
      }

      // province fetching
      var response2 = await https.client.get(https.proviceUri.toString());
      List<dynamic> body = jsonDecode(response2.body);

      var province = body
          .map(
            (dynamic data) => Province.fromJSON(data),
          )
          .toList();

      if (countryName.toLowerCase() == "USA".toLowerCase()) countryName = 'us';
      if (countryName.toLowerCase() == "uk".toLowerCase())
        countryName = 'United Kingdom';

      _setCountryData(
        Country.fromJSON(country),
        (stats != null) ? CountryStats.fromJSON(stats) : null,
        province.where(
          (prov) {
            return prov.country.toLowerCase() == countryName.toLowerCase();
          },
        ).toList(),
      );

      countryNotifierState = NotifierState.Loaded;
      notifyListeners();
    } on SocketException {
      _setErrorMsg("No Internet Connection");
      countryNotifierState = NotifierState.Failed;

      notifyListeners();
    } on ClientException {
      _setErrorMsg("Server Problem");
      countryNotifierState = NotifierState.Failed;

      notifyListeners();
    } catch (e) {
      _setErrorMsg("Connection Problem");
      countryNotifierState = NotifierState.Failed;

      notifyListeners();
    }
  }

  List<Country> get countries => [..._countries];
  List<Country> get filteredCountries => [..._filteredCountries];

  Country get country => _country;
  CountryStats get timeline => _stats;
  List<Province> get countryProvince => _countryProvince;
}
