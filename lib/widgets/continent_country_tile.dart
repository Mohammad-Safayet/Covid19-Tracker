import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ContinentContryTile extends StatelessWidget {
  final String name;
  final int cases;
  final int deaths;
  final int continentCases;
  final int continentDeaths;

  const ContinentContryTile({
    Key key,
    this.name,
    this.cases,
    this.deaths,
    this.continentCases,
    this.continentDeaths,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white10,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(18.0),
              child: CircleAvatar(
                backgroundColor: kBorderColor,
                maxRadius: MediaQuery.of(context).size.width * 0.015,
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                name,
                style: kCountryCardTitleStyle.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Divider(
              thickness: 1.0,
              color: kBorderColor,
            ),
          ),
          SizedBox(
            height: 25.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: kHomeCardTextStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                  children: [
                    TextSpan(
                      text:
                          (cases * 100 / continentCases).toStringAsPrecision(2),
                    ),
                    TextSpan(
                      text: '%',
                    ),
                    TextSpan(text: '\n\nConfirmed'),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: kHomeCardTextStyle.copyWith(
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                  children: [
                    TextSpan(
                      text: (deaths * 100 / continentDeaths)
                          .toStringAsPrecision(2),
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(
                      text: '%',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    TextSpan(text: '\n\nDeaths'),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25.0,
          ),
        ],
      ),
    );
  }
}
