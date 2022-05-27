// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sahabit_apps/home/home_page.dart';
import 'package:sahabit_apps/maps_page.dart';
import 'package:sahabit_apps/profil/profil_page.dart';
import 'package:sahabit_apps/transaksi/pembayaran/list_pembayaran.dart';
import 'package:sahabit_apps/transaksi/status_page.dart';
import 'package:sahabit_apps/transaksi/transaksi_page.dart';

class LandingPage extends StatefulWidget {
  final String nav;

  const LandingPage({Key key, this.nav}) : super(key: key);
  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;
  final List<Widget> _container = [
    HomePage(),
    TransaksiPage(),
    VoucherPage(),
    StatusPage(),
    ProfilPage(),
  ];

  @override
  void initState() {
    super.initState();
    if (widget.nav == '0') {
      _bottomNavCurrentIndex = 0;
    } else if (widget.nav == '1') {
      _bottomNavCurrentIndex = 1;
    } else if (widget.nav == '2') {
      _bottomNavCurrentIndex = 2;
    } else if (widget.nav == '3') {
      _bottomNavCurrentIndex = 3;
    } else if (widget.nav == '4') {
      _bottomNavCurrentIndex = 4;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _bottomNavCurrentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
                onTabChange: (index) {
                  setState(() {
                    _bottomNavCurrentIndex = index;
                  });
                },
                selectedIndex: _bottomNavCurrentIndex,
                rippleColor: Colors.grey[300],
                hoverColor: Colors.grey[100],
                gap: 8,
                activeColor: Colors.white,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Color.fromARGB(255, 159, 94, 238),
                color: Colors.black, // navigation bar padding
                tabs: const [
                  GButton(
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.bookmark,
                    text: 'Bookmark',
                  ),
                  GButton(
                    icon: Icons.bookmark,
                    text: 'Event',
                  ),
                  GButton(
                    icon: Icons.book,
                    text: 'Booking',
                  ),
                  GButton(
                    icon: Icons.person,
                    text: 'Profil',
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
