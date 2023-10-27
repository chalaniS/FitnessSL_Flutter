import 'package:flutter/material.dart';

class EventDetailPage extends StatefulWidget {
  final Map<String, dynamic> eventData;

  EventDetailPage({required this.eventData});

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Event Name: ${widget.eventData['eventName']}'),
            Text('Category: ${widget.eventData['category']}'),
            Text('Age Gap: ${widget.eventData['ageGap']}'),
            Text('Description: ${widget.eventData['description']}'),
            Text('Date: ${widget.eventData['date']}'),
            Text('Time: ${widget.eventData['time']}'),
            // You can add more details here as needed.
          ],
        ),
      ),
    );
  }
}
