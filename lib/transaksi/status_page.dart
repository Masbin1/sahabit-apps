// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:sahabit_apps/login_page.dart';
import 'package:sahabit_apps/transaksi/komponent/status_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  bool login = false;
  String userid = "";

  @override
  void initState() {
    super.initState();
    cekLogin();
  }

  cekLogin() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      login = prefs.getBool('login') ?? false;
      userid = prefs.getString('username') ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: login
          ? StatusLogin(
              userid: userid,
            )
          : LoginPage(),
    );
  }
}
