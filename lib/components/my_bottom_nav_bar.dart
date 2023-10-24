import 'package:fitness/screens/User/profile_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../screens/home/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  // static final List<Widget> _widgetOptions = <Widget>[
  //   HomePage(),
  //   const Text("Calendar"),
  //   const Text("Analytics"),
  //   const ChatHome(),
  //   const Text("Profile"),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: darkBlue,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      iconSize: 30,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      // onTap: _onItemTapped,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined, color: grey),
          activeIcon: Icon(Icons.home_filled, color: yellow),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today_outlined, color: grey),
          activeIcon: Icon(Icons.calendar_today, color: yellow),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics_outlined, color: grey),
          activeIcon: Icon(Icons.analytics_rounded, color: yellow),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.forum_outlined, color: grey),
          activeIcon: Icon(Icons.forum_rounded, color: yellow),
          label: 'Messenger',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline, color: grey),
          activeIcon: Icon(Icons.person, color: yellow),
          label: 'Profiles',
        ),
      ],
      onTap: (int index) {
        if (index == 3) {
          // Check if the profile icon was tapped
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(), // Navigate to your profile page
            ),
          );
        } else if (index == 0) {
          // Check if the profile icon was tapped
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => HomePage(), // Navigate to your profile page
            ),
          );
        } else if (index == 4) {
          // Check if the profile icon was tapped
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Profile(), // Navigate to your profile page
            ),
          );
        }
      },
    );
  }
}
