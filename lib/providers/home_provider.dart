import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:http/http.dart';

import '../services/https.dart';
import '../models/country.dart';
import '../services/location.dart';
import '../models/country_stats.dart';
import '../models/province.dart';

enum NotifierState {
  Loading,
  Loaded,
  Failed,
  NotFound,
}

class HomeProvider with ChangeNotifier {
  Country _home;
  CountryStats _stats;
  List<Province> _homeProvince;
  bool _status;

  NotifierState notifierState;
  String errMsg;
  final Https https = Https();
  Location location = Location();

  Future<void> isHomeAvailable() async {
    try {
      notifierState = NotifierState.Loading;

      _status = await location.isLoactionEnabled();

      notifierState = NotifierState.Loaded;
      notifyListeners();
    } catch (err) {
      _setErrorMsg(err.message);
      notifierState = NotifierState.Failed;

      notifyListeners();
    }
  }

  Future<void> getWorldData() async {
    try {
      notifierState = NotifierState.Loading;

      var response = await https.client.get(https.worldUri.toString());
      var country = jsonDecode(response.body);

      var response1 = await https.client.get(
        https.statUri.toString() + '/all',
      );
      var stats;

      if (response1.statusCode != 200) {
        stats = null;
      } else {
        stats = jsonDecode(response1.body);
      }

      _setHomeData(
        Country.world(country),
        (stats != null) ? CountryStats.world(stats) : null,
        [],
      );

      notifierState = NotifierState.Loaded;
      notifyListeners();
    } on SocketException {
      _setErrorMsg("Whoops! No Internet Connection");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } on ClientException {
      _setErrorMsg("Whoops! Server Faliure");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } catch (e) {
      _setErrorMsg('Whoops! Can\'t reach the server');
      notifierState = NotifierState.Failed;

      notifyListeners();
    }
  }

  Future<void> getHomeData() async {
    String countryName;

    try {
      notifierState = NotifierState.Loading;

      await location.getCurrentLocation();
      countryName = location.countryName;

      // Country fetching
      var response = await https.client.get(
        https.countryUri.toString() + '/$countryName',
      );
      var country = jsonDecode(response.body);

      // stats fetching
      var response1 = await https.client.get(
        https.statUri.toString() + '/$countryName',
      );
      var stats;

      if (response1.statusCode == 404) {
        stats = null;
      } else {
        stats = jsonDecode(response1.body);
      }

      // province fetching
      var response2 = await https.client.get(https.proviceUri.toString());
      List<dynamic> body = jsonDecode(response2.body);

      var province;
      if (response2.statusCode == 404) {
        province = [];
      } else {
        province = body
            .map(
              (dynamic data) => Province.fromJSON(data),
            )
            .toList();

        if (countryName.toLowerCase() == "USA".toLowerCase())
          countryName = 'us';
        if (countryName.toLowerCase() == "uk".toLowerCase())
          countryName = 'United Kingdom';
      }

      _setHomeData(
        Country.fromJSON(country),
        (stats != null) ? CountryStats.fromJSON(stats) : null,
        province.where(
          (province) {
            return province.country.toLowerCase() == countryName.toLowerCase();
          },
        ).toList(),
      );

      notifierState = NotifierState.Loaded;
      notifyListeners();
    } on SocketException {
      _setErrorMsg("Whoops! No Internet Connection");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } on ClientException {
      _setErrorMsg("Whoops! Server Faliure");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } catch (e) {
      _setErrorMsg('Whoops! Can\'t reach the server');
      notifierState = NotifierState.Failed;

      notifyListeners();
    }
  }

  void _setErrorMsg(String str) {
    errMsg = str;
  }

  void _setHomeData(
    Country country,
    CountryStats stats,
    List<Province> province,
  ) {
    _home = country;
    _stats = stats;
    _homeProvince = province;
  }

  Country get home => _home;
  bool get status => _status;
  CountryStats get stats => _stats;
  List<Province> get homeProvince => _homeProvince;
}
