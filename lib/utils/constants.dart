import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

String formatNumber(dynamic data) {
  final nf = NumberFormat("#,###");

  return '${nf.format(data)}';
}

typedef FormatBarLabel = String Function(num data);

FormatBarLabel formatBarLabel = (data) {
  return NumberFormat.compactCurrency(
    decimalDigits: 1,
    symbol: '',
  ).format(data);
};

String formatBarTitle(String str) {
  int count = 0;
  if (str.contains('/'))
    return str
        .split('/')
        .map((ch) {
          count++;
          return (ch != 'Oceania') ? ch + '\n/' : ch;
        })
        .join(' ')
        .substring(0, str.length + count);

  return str
      .split(' ')
      .map((ch) {
        count++;
        return ch + '\n';
      })
      .join(' ')
      .substring(0, str.length + count - 1);
}

const kPopUpMenuItemStyle = TextStyle(
  color: Colors.white,
  fontSize: 15.0,
  fontFamily: "Oxanium",
  fontWeight: FontWeight.w500,
  letterSpacing: 5.0,
);

const kHomeCardTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 15.0,
  fontFamily: "Quicksand",
  fontWeight: FontWeight.w500,
  letterSpacing: 5.0,
);

const kCountryCardTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 20.0,
  fontFamily: "JosefinSlab",
  fontWeight: FontWeight.w900,
  letterSpacing: 5.0,
);

const kContinentCardTitleStyle = TextStyle(
  color: Colors.white,
  fontSize: 15.0,
  fontFamily: "Oxanium",
  fontWeight: FontWeight.w900,
  letterSpacing: 5.0,
  height: 2.5,
);

const kCountryCardDetailsStyle = TextStyle(
  color: Colors.white,
  fontFamily: "Oxanium",
  fontWeight: FontWeight.w900,
  letterSpacing: 3.0,
);

Color kBorderColor = Color(0xFF00AF80).withOpacity(1.0);
