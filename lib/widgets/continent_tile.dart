import 'package:flutter/material.dart';

import '../screens/continent_page.dart';
import '../utils/constants.dart';

class ContinentTile extends StatelessWidget {
  final String name;
  final int confirmed;
  final int deaths;
  final int recovered;
  final double height;

  const ContinentTile({
    this.name,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => ContinentPage(
              continentName: name,
            ),
          ),
        );
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.60,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(12.0),
          color: Color(0xFF1D1E33),
          // color: Colors.white,
        ),
        padding: const EdgeInsets.all(12.0),
        margin: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              height: height * 0.2,
              padding: EdgeInsets.only(left: 25.0),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 10.0,
                    height: height * 0.05,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: kBorderColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 28.0),
                    child: Text(
                      formatBarTitle(name),
                      style: kCountryCardDetailsStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 5.0,
              color: kBorderColor,
            ),
            Container(
              height: height * 0.35,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 15.0,
                  ),
                  RichText(
                    text: TextSpan(
                      style: kHomeCardTextStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        wordSpacing: 15.0,
                      ),
                      children: [
                        TextSpan(
                          text: (confirmed > 999)
                              ? formatBarLabel(confirmed)
                              : confirmed.toString(),
                        ),
                        TextSpan(text: '\t\t\tConfirmed'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: kHomeCardTextStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        wordSpacing: 15.0,
                      ),
                      children: [
                        TextSpan(
                          text: (deaths > 999)
                              ? formatBarLabel(deaths)
                              : deaths.toString(),
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                        TextSpan(text: '\t\t\t\t\t\t\t\tDeaths'),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      style: kHomeCardTextStyle.copyWith(
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        wordSpacing: 15.0,
                      ),
                      children: [
                        TextSpan(
                          text: (recovered > 999)
                              ? formatBarLabel(recovered)
                              : recovered.toString(),
                          style: TextStyle(
                            color: Colors.green,
                          ),
                        ),
                        TextSpan(text: '\t\t\tRecovered'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
