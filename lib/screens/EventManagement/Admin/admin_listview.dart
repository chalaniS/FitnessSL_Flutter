import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fitness/screens/EventManagement/Admin/add_events.dart';

class EventListView extends StatefulWidget {
  @override
  _EventListViewState createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
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

  // Function to delete an event by its key
  // void deleteEvent(String key) {
  //   databaseReference.child(key).remove();
  // }

  void deleteEvent(String key) {
    databaseReference.child(key).remove().then((_) {
      // The event is successfully deleted from the database.
      // Now, remove it from the local list.
      setState(() {
        eventsData.removeWhere((event) => event.keys.first == key);
      });
    }).catchError((error) {
      // Handle any errors that occur during deletion.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 7, 16, 68),
        title: const Text(
          'Event Time Table List',
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
      body: ListView(
        children: <Widget>[
          Padding(
            // padding: const EdgeInsets.all(16.0),
            padding: const EdgeInsets.symmetric(horizontal: 180.0),

            child: ElevatedButton(
              onPressed: () {
                ///when clicked on button page navigate to add event page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEventForm(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange, //background color of the button
                foregroundColor: Colors.black, //color of the text
                //width and height of the button
                minimumSize: const Size(200, 40),
              ),
              child: const Text(
                'Add Event',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: eventsData.length,
            itemBuilder: (context, index) {
              //event list items
              final event = eventsData[index];
              final eventKey = event.keys.first; // Key of the event

              return Container(
                padding: const EdgeInsets.all(8),
                child: Card(
                  color: const Color.fromARGB(
                      255, 173, 209, 238), // Set the background color here
                  elevation: 2,
                  child: Container(
                    height: 110, // Set the desired height of the ListTile
                    child: ListTile(
                      title: Text(
                        ' ${event['eventName']}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            'Date: ${event['date'].split(' ')[0]}', // This extracts only the date part
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'Time: ${event['time']}',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            //icon: const Icon(Icons.edit),
                            onPressed: () {
                              // Handle update event action
                              // You can navigate to an edit page or show a dialog for editing.
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 200,
                                  175, 230), //background color of edit button
                            ),
                            child: const Text(
                              'Update',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              print(
                                  "Delete button pressed for event key: $eventKey");
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      'Confirm Deletion',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    content: const Text(
                                      'Are you sure you want to delete this event?',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('Delete'),
                                        onPressed: () {
                                          deleteEvent(eventKey);
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromARGB(255, 238,
                                  119, 119), //background color of edit button
                              minimumSize: const Size(85,
                                  40), // Increase the width and height of the button
                            ),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
