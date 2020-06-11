import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/country_provider.dart';
import '../utils/constants.dart';

enum Catagories {
  Active,
  Case,
  Country,
  TotalDeaths,
  Recovered,
  TodayDeaths,
  TodayCases,
}

List<String> states = [
  'active',
  'cases',
  'country',
  'deaths',
  'recovered',
  'todayCases',
  'todayDeaths',
];

List<String> data = [
  'Active',
  'Cases',
  'Country',
  'Deaths',
  'Recovered',
  'New Cases',
  'New Deaths',
];

class CovidDropDownMenu extends StatefulWidget {

  @override
  _CovidDropDownMenuState createState() => _CovidDropDownMenuState();
}

class _CovidDropDownMenuState extends State<CovidDropDownMenu> {
  String selected;
  Catagories selectedCatagory;

  @override
  void initState() {
    super.initState();

    String state = Provider.of<CountryProvider>(context, listen: false).state;
    selectedCatagory = Catagories.values[states.indexOf(state)];
    selected = data[states.indexOf(state)];
  }

  void changeTheValue(Catagories value) async {
    await Provider.of<CountryProvider>(context, listen: false)
        .getTheCountries(states[value.index]);
    
    setState(() {
      selected = data[value.index];
      selectedCatagory = value;
      print(selected);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Catagories>(
      
      value: selectedCatagory,
      icon: Icon(
        Icons.arrow_drop_down,
        color: Colors.white,
      ),
      iconSize: 24,
      elevation: 16,
      hint: Text('data'),
      underline: Container(
        height: 0,
      ),
      onChanged: changeTheValue,
      items: [
        ...data.asMap().entries.map(
          (item) {
            return DropdownMenuItem<Catagories>(
              value: Catagories.values[item.key],
              child: Text(
                item.value,
                style: kPopUpMenuItemStyle.copyWith(
                  letterSpacing: 0,
                  color: selected == item.value ? kBorderColor : Colors.white,
                  fontWeight: selected == item.value
                      ? FontWeight.w700
                      : FontWeight.w400,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
