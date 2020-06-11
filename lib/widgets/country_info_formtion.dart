import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CountryInfoFormation extends StatelessWidget {
  final String text;
  final int data;

  const CountryInfoFormation({
    @required this.text,
    @required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            style: kHomeCardTextStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.035,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            formatNumber(data),
            style: kHomeCardTextStyle.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: MediaQuery.of(context).size.width * 0.04,
            ),
          ),
        ),
      ],
    );
  }
}
