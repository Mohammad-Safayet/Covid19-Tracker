import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CountryDetails extends StatelessWidget {
  final dynamic text;
  final dynamic value;

  const CountryDetails({
    @required this.text,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.white,
            width: 0.2,
          ),
        ),
      ),
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            '$text',
            style: kCountryCardDetailsStyle.copyWith(
                fontSize: MediaQuery.of(context).size.width * 0.03,
              ),
          ),
          Text(
            formatNumber(value ?? 0),
            style: kCountryCardDetailsStyle.copyWith(
              fontSize: MediaQuery.of(context).size.width * 0.035,
            ),
          ),
        ],
      ),
    );
  }
}
