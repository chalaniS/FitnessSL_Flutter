// import 'package:flutter/material.dart';
// import 'package:firebase_database/firebase_database.dart';

// class EventDetailPage extends StatefulWidget {
//   final Map<String, dynamic> eventData;

//   EventDetailPage({required this.eventData});

//   @override
//   _EventDetailPageState createState() => _EventDetailPageState();
// }

// class _EventDetailPageState extends State<EventDetailPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Event Details'),
//       ),
//       body: Container(
//         padding: EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Event Name: ${widget.eventData['eventName']}'),
//             Text('Category: ${widget.eventData['category']}'),
//             Text('Age Gap: ${widget.eventData['ageGap']}'),
//             Text('Description: ${widget.eventData['description']}'),
//             Text('Date: ${widget.eventData['date']}'),
//             Text('Time: ${widget.eventData['time']}'),
//             // You can add more details here as needed.
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class EventDetailPage extends StatefulWidget {
  final String eventKey;

  EventDetailPage({required this.eventKey});

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  final DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('events');

  Future<Map<String, dynamic>> fetchEventData() async {
    DataSnapshot dataSnapshot =
        await databaseReference.child(widget.eventKey).once() as DataSnapshot;

    if (dataSnapshot.value != null) {
      return dataSnapshot.value as Map<String, dynamic>;
    }
    return {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchEventData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Event not found.'));
          }

          final eventData = snapshot.data;

          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Event Name: ${eventData?['eventName']}'),
                Text('Category: ${eventData?['category']}'),
                Text('Age Gap: ${eventData?['ageGap']}'),
                Text('Description: ${eventData?['description']}'),
                Text('Date: ${eventData?['date']}'),
                Text('Time: ${eventData?['time']}'),
                // You can add more details here as needed.
              ],
            ),
          );
        },
      ),
    );
  }
}
