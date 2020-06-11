import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

import '../widgets/covid_app_bar.dart';
import '../utils/constants.dart';

class AboutPage extends StatelessWidget {
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: true,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: CovidAppBar(
          title: "About",
          appBarWidget: IconButton(
            icon: Icon(
              Icons.close,
              color: Colors.white,
              size: 32.0,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(13.0),
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: <Widget>[
                Card(
                  color: kBorderColor,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "NovelCOVID",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        "Rest API",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _launchURL('https://github.com/NovelCOVID/API');
                    },
                  ),
                ),
                Card(
                  color: kBorderColor,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Shamsul Tazour Rafi",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        "Design",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _launchURL('https://www.facebook.com/shamsultazour.rafi');
                    },
                  ),
                ),
                Card(
                  color: kBorderColor,
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Mohammad Safayet Latif",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 28.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        "Developer",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15.0,
                        ),
                      ),
                    ),
                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _launchURL('https://www.facebook.com/Safayet.Latif');
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
