import 'package:flutter/material.dart';

import '../widgets/world_card_info.dart';
import '../screens/country_page.dart';
import '../utils/constants.dart';

class CovidCard extends StatelessWidget {
  final String iso;
  final String name;
  final String flag;
  final int value;
  final String text;

  const CovidCard({
    Key key,
    @required this.iso,
    @required this.name,
    @required this.flag,
    @required this.value,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => CountryPage(
              countryName: name,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 6.0,
          horizontal: 12.0,
        ),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          border: Border.all(color: kBorderColor.withOpacity(0.4)),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(5.0),
            bottomRight: Radius.circular(30.0),
            bottomLeft: Radius.circular(30.0),
          ),
          color: Color(0xFF1D1E33),
          // color: Colors.white,
        ),
        height: 90.0,
        child: Center(
          child: CovidCardInfo(
            width: MediaQuery.of(context).size.width * 0.75,
            name: iso,
            flag: flag,
            value: value,
            text: text,
          ),
        ),
      ),
    );
  }
}
