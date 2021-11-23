import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/user/change_password.dart';
import 'package:flutter_firebase_app/user/dashboard.dart';
import 'package:flutter_firebase_app/user/profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    Profile(),
    ChangePaaword(),
  ];

  void onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: "Dashboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "Change Password")
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: onTapped,
      ),
    );
  }
}
