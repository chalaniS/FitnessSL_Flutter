import 'package:fitness/screens/User/profile_page.dart';
import 'package:flutter/material.dart';

import '../constants.dart'; // Import your profile page

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromARGB(
          0, 69, 8, 8), // Set the background color to transparent
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: darkBlue,
            size: 30,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.calendar_today,
            color: darkBlue,
            size: 30,
          ),
          label: 'Calendar',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.analytics,
            color: darkBlue,
            size: 30,
          ),
          label: 'Analytics',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            color: darkBlue,
            size: 30,
          ),
          label: 'Profiles',
        ),
      ],
      onTap: (int index) {
        if (index == 3) {
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
