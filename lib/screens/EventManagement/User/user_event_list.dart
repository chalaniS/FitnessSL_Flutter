import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UserEventListView extends StatefulWidget {
  @override
  _UserEventListViewState createState() => _UserEventListViewState();
}

class _UserEventListViewState extends State<UserEventListView> {
  List<Map<String, dynamic>> eventsData = [];
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('events');

  DateTime? selectedDate; // Store the selected date

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Column(
          children: [
            Image.asset(
              'images/home/yoga.gif',
              width: 480,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: eventsData.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: const Color.fromARGB(255, 173, 209, 238),
                    elevation: 2,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 3,
                              child: ListTile(
                                title: Text(
                                  '${eventsData[index]['eventName']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
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
                                      'Date: ${eventsData[index]['date'].split(' ')[0]}',
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
                              ),
                            ),
                            Flexible(
                              flex: 2,
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle Add Reservations button click
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 108, 155, 139),
                                      ),
                                      child: const Text('Reservations'),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    width: 125,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        final String dateString =
                                            eventsData[index]['date']
                                                .split(' ')[0];
                                        selectedDate =
                                            DateTime.parse(dateString);
                                        _showCalendarDialog(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 157, 87, 236),
                                      ),
                                      child: const Text('Calendar'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCalendarDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            width: 300, // Adjust the width as needed
            height: 400, // Adjust the height as needed
            child: SfCalendar(
              view: CalendarView.month,
              backgroundColor: const Color.fromARGB(255, 218, 215, 228),
              viewHeaderStyle: const ViewHeaderStyle(
                backgroundColor: Color.fromARGB(255, 124, 33, 243),
                dayTextStyle: TextStyle(color: Colors.white),
              ),
              todayHighlightColor: const Color.fromARGB(255, 42, 198, 236),
              selectionDecoration: BoxDecoration(
                color: const Color.fromARGB(255, 84, 24, 112).withOpacity(0.5),
                border:
                    Border.all(color: const Color.fromARGB(255, 33, 243, 61)),
              ),
              specialRegions: <TimeRegion>[
                if (selectedDate != null)
                  TimeRegion(
                    startTime: selectedDate!,
                    endTime: selectedDate!.add(const Duration(days: 1)),
                    enablePointerInteraction: false,
                    color: const Color.fromARGB(255, 33, 243, 61),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
