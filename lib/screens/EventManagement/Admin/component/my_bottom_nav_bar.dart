import 'package:fitness/constants.dart';
import 'package:flutter/material.dart';

//import '..../constants.dart';

class MyBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: darkBlue, // Set the background color to dark blue
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: yellow,
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today,
            color: yellow,
            size: 30,
          ),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: yellow,
            size: 30,
          ),
          label: 'Profiles',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.analytics,
            color: yellow,
            size: 30,
          ),
          label: 'Analytics',
        ),
      ],
    );
  }
}
