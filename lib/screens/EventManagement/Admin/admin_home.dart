import 'package:fitness/screens/EventManagement/Admin/admin_listview.dart';
import 'package:flutter/material.dart';

class AdminHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: null,
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250, // Adjust the width as needed
              height: 250, // Adjust the height as needed
              child: Image.asset('images/logo.png'),
            ),

            const SizedBox(
                height: 16), // Add some space between the image and text.
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
                height: 30), // Add some space between the text and buttons.
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EventListView(),
                      ),
                    );
                    // Handle the action for the button.
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color.fromARGB(
                        255, 255, 191, 53), // Set the text color
                    minimumSize:
                        const Size(200, 50), // Set the desired width and height
                  ),
                  child: const Text(
                    'Events',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),

                const SizedBox(
                    height: 20), // Add some space between the buttons.
                ElevatedButton(
                  onPressed: () {
                    // Handle the action for the button.
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(
                        255, 255, 191, 53), // Set the background color
                    onPrimary: Colors.black, // Set the text color
                    minimumSize:
                        const Size(200, 50), // Set the desired width and height
                  ),
                  child: const Text(
                    'Manage Gyms',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                const SizedBox(
                    height: 20), // Add some space between the buttons.

                ElevatedButton(
                  onPressed: () {
                    // Handle the action for the button.
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 255, 191,
                        53), // Set the background color for button
                    onPrimary: Colors.black, // Set the text color
                    // minimumSize:
                    //     const Size(200, 50), //Set width and height of btn
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Text(
                    'Message',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
