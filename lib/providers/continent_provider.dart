import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import '../models/continent.dart';
import '../models/country.dart';
import '../services/https.dart';

enum NotifierState {
  Loading,
  Loaded,
  Failed,
  NotFound,
}

class ContinentProvider with ChangeNotifier {
  List<Continent> _world = [];
  Continent _continent;
  List<ContinentCountry> _list;
  Continent temp;
  final Https https = Https();

  String errMsg;
  NotifierState notifierState;

  List<Continent> get world => _world;

  void _setErrorMsg(String str) {
    errMsg = str;
  }

  void _initWorld() {
    _world = [];
    final continentName = [
      'Africa',
      'Asia',
      'Australia/Oceania',
      'Europe',
      'North America',
      'South America',
//      'Other',
    ];

    continentName.forEach((name) {
      temp = Continent(
        name: name,
        totalCases: 0,
        totalDeaths: 0,
        totlaRecovered: 0,
        totalActive: 0,
      );

      _world.add(temp);
    });
  }

  void _addCountry(Country country) {
    if (country.continent == '') return;

    temp =
        _world.firstWhere((continent) => continent.name == country.continent);

    temp.totalCases += country.cases;
    temp.totalDeaths += country.deaths;
    temp.totlaRecovered += country.recovered;
    temp.totalActive += country.active;
  }

  Future<void> getData() async {
    try {
      notifierState = NotifierState.Loading;

      _initWorld();
      var response = await https.client.get(https.countryUri.toString());

      List<dynamic> body = jsonDecode(response.body);
      var countries = body.map(
        (dynamic data) {
          return Country.fromJSON(data);
        },
      ).toList();

      countries.forEach((country) {
        _addCountry(country);
      });

      notifierState = NotifierState.Loaded;
      notifyListeners();
    } on SocketException {
      _setErrorMsg("No Internet Connection");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } on ClientException {
      _setErrorMsg("Server Problem");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } catch (e) {
      print(e);
      _setErrorMsg("Connection Problem");
      notifierState = NotifierState.Failed;

      notifyListeners();
    }
  }

  Future<void> getContinent(String name) async {
    try {
      notifierState = NotifierState.Loading;

      _continent = _world.firstWhere((continent) => continent.name == name);
      var response;
      if (name.contains('/')) name = name.split('/')[0];

      response = await https.client.get(
        'https://covid19-update-api.herokuapp.com/api/v1/world/continent' +
            '/${name.split(' ')[0]}',
      );

      Map<String, dynamic> body = jsonDecode(response.body);
      List<dynamic> _body = body['countries'];

      _list = _body
          .map(
            (dynamic data) => ContinentCountry.fromJSON(data),
          )
          .toList();

      notifierState = NotifierState.Loaded;
      notifyListeners();
    } on SocketException {
      _setErrorMsg("No Internet Connection");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } on ClientException {
      _setErrorMsg("Server Problem");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } catch (e) {
      print(e);
      _setErrorMsg("Connection Problem");
      notifierState = NotifierState.Failed;

      notifyListeners();
    }
  }

  @deprecated
  Future<void> getTheCountries(String value) async {
    try {
      notifierState = NotifierState.Loading;
      var response;
      if (value.contains('/')) value = value.split('/')[0];

      response = await https.client.get(
          'https://covid19-update-api.herokuapp.com/api/v1/world/continent' +
              '/${value.split(' ')[0]}');

      if (response.statusCode == 200) {
        notifyListeners();

        Map<String, dynamic> body = jsonDecode(response.body);
        List<dynamic> _body = body['countries'];

        _list = _body
            .map(
              (dynamic data) => ContinentCountry.fromJSON(data),
            )
            .toList();
      } else {
        notifyListeners();
        throw 'Unable to fetch the data';
      }
    } on SocketException {
      _setErrorMsg("No Internet Connection");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } on ClientException {
      _setErrorMsg("Server Problem");
      notifierState = NotifierState.Failed;

      notifyListeners();
    } catch (e) {
      print(e);
      _setErrorMsg("Connection Problem");
      notifierState = NotifierState.Failed;

      notifyListeners();
    }
  }

  List<Continent> sort(int condition) {
    var _temp = [..._world];
    _temp.sort((con1, con2) {
      if (condition == 1) {
        return con2.totalDeaths.compareTo(con1.totalDeaths);
      }
      if (condition == 2) {
        return con2.totlaRecovered.compareTo(con1.totlaRecovered);
      }
      return con2.totalCases.compareTo(con1.totalCases);
    });

    return [..._temp];
  }

  List<ContinentCountry> get list => _list;
  Continent get continent => _continent;
}
