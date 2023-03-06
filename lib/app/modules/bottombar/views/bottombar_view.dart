import 'package:crud_pegawai/app/constant/color.dart';
import 'package:crud_pegawai/app/dynamic/content.dart';
import 'package:crud_pegawai/app/modules/Addcontenview/views/addcontenview_view.dart';
import 'package:crud_pegawai/app/modules/Content/views/addcontet.dart';
import 'package:crud_pegawai/app/modules/Content/views/content_view.dart';
import 'package:crud_pegawai/app/modules/ProfilView/views/profil_view_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../controllers/bottombar_controller.dart';

class BottombarView extends StatefulWidget {
  const BottombarView({Key? key}) : super(key: key);

  @override
  State<BottombarView> createState() => _BottombarViewState();
}

class _BottombarViewState extends State<BottombarView> {
  late var _pgno = [
    ContentView(),
    AddcontentView(),
  ];
  int _pilihtabbar = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Home',
      style: optionStyle,
    ),
    Text(
      'Profile',
      style: optionStyle,
    ),
  ];

  void _changetabbar(int index) {
    setState(() {
      _pilihtabbar = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _pgno = [ContentView(), AddcontentView()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pgno[_pilihtabbar],
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
              rippleColor: Color(0xFF0595A7)!,
              hoverColor: Color(0xFF095160)!,
              gap: 3,
              activeColor: appPrimary,
              iconSize: 18,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: appPrimary,
              tabs: [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.add,
                  text: 'Add',
                ),
              ],
              selectedIndex: _pilihtabbar,
              onTabChange: (index) {
                setState(() {
                  _pilihtabbar = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
