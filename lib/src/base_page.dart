// base_page.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hello/src/recent_activity_page.dart';
import 'mappage.dart';
import 'welcome_page.dart';
import 'dashboard_page.dart';

class BasePage extends StatefulWidget {
  final Widget child;
  final int currentIndex;

  const BasePage({required this.child, required this.currentIndex, super.key});

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => WelcomePage(userName: _auth.currentUser?.displayName ?? 'User')),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BasePage(currentIndex: 1, child: MapPage())),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BasePage(currentIndex: 2, child: RecentActivityPage())),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BasePage(currentIndex: 3, child: DashboardPage())),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = _auth.currentUser;

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.mapMarkedAlt),
            label: 'Map',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Activity',
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
           label: 'Account',
          ),


        ],
        currentIndex: widget.currentIndex,
        selectedItemColor: Colors.blueGrey,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}