import 'package:flutter/material.dart';

import '../utils/constants.dart';

class ProvinceTile extends StatelessWidget {
  final String name;
  final int confirmed;
  final int deaths;
  final int recovered;

  const ProvinceTile({
    this.name,
    this.confirmed,
    this.deaths,
    this.recovered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10.0,
                height: 10.0,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: kBorderColor,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    name ?? 'MainLand',
                    style: kCountryCardDetailsStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.047,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: VerticalDivider(
                    color: Colors.white,
                    thickness: 1.0,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: kHomeCardTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                    children: [
                      TextSpan(
                        text: formatNumber(confirmed),
                      ),
                      TextSpan(text: '\n\nConfirmed'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: kHomeCardTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                    children: [
                      TextSpan(
                        text: formatNumber(deaths),
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                      TextSpan(text: '\n\nDeaths'),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: kHomeCardTextStyle.copyWith(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.5,
                    ),
                    children: [
                      TextSpan(
                        text: formatNumber(recovered),
                        style: TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      TextSpan(text: '\n\nRecovered'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
