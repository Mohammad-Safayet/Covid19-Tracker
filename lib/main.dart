import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import './screens/stats_page.dart';
import './widgets/covid_app_bar.dart';
import './screens/world_page.dart';
import './screens/home_page.dart';
import './screens/about_page.dart';
import './providers/country_provider.dart';
import './providers/home_provider.dart';
import './providers/continent_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CountryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContinentProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Covid Tracker',
      theme: ThemeData(
        canvasColor: Color(0xFF111010),
        primaryColor: Color(0xFF111010),
      ),
      home: MainLayout(),
    );
  }
}

class MainLayout extends StatefulWidget {
  @override
  _MainLayoutState createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _index = 0;

  final List<Widget> _widget = <Widget>[
    HomePage(),
    WorldPage(),
    ContinentStatPage(),
  ];

  // final List<Widget> _appBarWidget = <Widget>[
  //   Icon(Icons.place),
  //   CovidPopUpMenu(),
  // ];

  final List<String> _titles = [
    "Home",
    "World",
    "Statistics",
  ];

  void _onItemTapped(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Theme.of(context).primaryColor,
        appBar: CovidAppBar(
          title: _titles.elementAt(_index),
          appBarWidget: IconButton(
            icon: Icon(
              Icons.info_outline,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AboutPage(),
                ),
              );
            },
          ),
        ),
        body: _widget.elementAt(_index),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.public),
              title: Text('World'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.equalizer),
              title: Text('Stats'),
            ),
          ],
          currentIndex: _index,
          selectedItemColor: Color(0xFF00AF80).withOpacity(1.0),
          unselectedItemColor: Colors.white,
          onTap: _onItemTapped,
          showUnselectedLabels: false,
          showSelectedLabels: false,
        ),
      ),
    );
  }
}
