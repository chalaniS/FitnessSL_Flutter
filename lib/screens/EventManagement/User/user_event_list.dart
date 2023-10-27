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
        title: Text('Event List'),
      ),
      body: ListView.builder(
        itemCount: eventsData.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8),
            child: Card(
              elevation: 2,
              child: ListTile(
                title: Text('Event Name: ${eventsData[index]['eventName']}'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Category: ${eventsData[index]['category']}'),
                    Text('Age Gap: ${eventsData[index]['ageGap']}'),
                    Text('Description: ${eventsData[index]['description']}'),
                    Text('Date: ${eventsData[index]['date']}'),
                    Text('Time: ${eventsData[index]['time']}'),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
