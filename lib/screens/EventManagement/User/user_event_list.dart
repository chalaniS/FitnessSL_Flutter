//user side
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class UserEventListView extends StatefulWidget {
  @override
  _UserEventListViewState createState() => _UserEventListViewState();
}

class _UserEventListViewState extends State<UserEventListView> {
  List<Map<String, dynamic>> eventsData = [];
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('events');

  @override
  void initState() {
    super.initState();
    databaseReference.onValue.listen((event) {
      eventsData.clear();
      if (event.snapshot.value != null) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, dynamic value) {
          eventsData.add(value);
        });

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 16, 68),
        title: const Text(
          'Event Time Tables',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Define the action when the arrow button is pressed, such as navigating back.
            // Example: Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: eventsData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Card(
              color: const Color.fromARGB(255, 173, 209, 238),
              elevation: 2,
              child: ListTile(
                title: Text(
                  ' ${eventsData[index]['eventName']}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Category: ${eventsData[index]['category']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Age Gap: ${eventsData[index]['ageGap']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Description: ${eventsData[index]['description']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Date: ${eventsData[index]['date']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Time: ${eventsData[index]['time']}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    // Define the action when the "View" button is pressed.
                    // For example, you can navigate to a detailed view of the event.
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailView(eventData: eventsData[index]));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(
                        255, 108, 155, 139), //background color of edit button
                  ),
                  child: Text('View'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
