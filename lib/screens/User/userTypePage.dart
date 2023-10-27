import 'package:fitness/screens/User/loginPage.dart';
import 'package:fitness/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class UserTypeSelection extends StatelessWidget {
  const UserTypeSelection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage("images/logo.png"),
              width: 280.0,
              alignment: Alignment.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the Admin side
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: yellow,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'As an Admin',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the User side
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MyLogin()));
                },
                style: ElevatedButton.styleFrom(
                  primary: yellow,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Text(
                  'As a user',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
