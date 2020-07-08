import 'package:flutter/material.dart';

import '../utils/constants.dart';

class CovidCardInfo extends StatelessWidget {
  final String name;
  final String flag;
  final int value;
  final String text;
  final double width;

  const CovidCardInfo({
    Key key,
    @required this.width,
    @required this.name,
    @required this.flag,
    @required this.value,
    @required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            maxRadius: 22.0,
            backgroundColor: kBorderColor,
            backgroundImage: (this.name == 'World')
                ? AssetImage('assets/images/intFlag.png')
                : NetworkImage(
                    this.flag,
                  ),
          ),
          SizedBox(
            width: width * 0.12,
          ),
          Flexible(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '${this.name}',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width * 0.06,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w700,
                      letterSpacing: 5.0,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 18.0,
                      top: 5.0,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${this.text}: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Oxanium",
                            fontSize: width * 0.045,
                          ),
                        ),
                        Text(
                          (this.text == 'New Deaths' ||
                                  this.text == 'New Cases')
                              ? " +" + formatNumber(value)
                              : " " + formatNumber(value),
                          style: TextStyle(
                            color: (this.value > 0 &&
                                    (this.text != 'Recovered' &&
                                        this.text != 'New Recovered'))
                                ? Colors.red
                                : Colors.green,
                            fontFamily: "Oxanium",
                            fontSize: width * 0.045,
                            letterSpacing: 2.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
