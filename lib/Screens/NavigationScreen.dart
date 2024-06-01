import 'package:flutter/material.dart';
import 'package:xfinitive/Screens/my_deviceforhome.dart';
import 'package:xfinitive/Screens/settings.dart';

import 'package:xfinitive/Screens/Home.dart';

class HomeScreen extends StatefulWidget {
  final String? name;
  HomeScreen({this.name});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController =
      PageController(initialPage: 0); // Start at the HomeScreen
  int _currentIndex = 0;
  // Start at the HomeScreen index

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [

           HomeScreendart(name: widget.name,),
          const MyDeviceScreenCopy(),
          // Placeholder for the HomeScreen widget

          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(Icons.devices),
            label: 'My Device',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.green,
            icon: Icon(
              Icons.settings,
            ),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
