import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CountryTitle extends StatelessWidget {
  final String countryName;
  final String flag;

  const CountryTitle({
    Key key,
    this.countryName,
    this.flag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (countryName != null)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: (this.countryName == 'World')
                    ? Image.asset(
                        this.flag,
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.width * 0.08,
                        width: MediaQuery.of(context).size.width * 0.12,
                      )
                    : Image.network(
                        '${this.flag}',
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.width * 0.08,
                        width: MediaQuery.of(context).size.width * 0.12,
                      ),
              ),
              Text(
                "$countryName",
                style: kHomeCardTextStyle.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                ),
              ),
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}
