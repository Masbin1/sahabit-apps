// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sahabit_apps/landing_page.dart';
import 'package:sahabit_apps/launcher_page.dart';

main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SAHABIT APPS',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LauncherPage(),
      routes: <String, WidgetBuilder>{
        '/landingusers': (context) => LandingPage(),
        '/keranjangusers': (context) => LandingPage(nav: '1'),
        // '/signup': (context) => SignupPage(),
        // '/forgot': (context) => Forgotpage(),
      },
    );
  }
}
