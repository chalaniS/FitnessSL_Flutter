import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:fitness/constants.dart';
import 'package:fitness/screens/home/home_screen.dart';
import 'package:fitness/screens/workout_plan/pages/create_routine.dart';
import 'package:fitness/screens/workout_plan/pages/display_a_routine.dart';
import 'package:fitness/screens/workout_plan/utils/colors_util.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({Key? key}) : super(key: key);

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  DateTime _selectedDate = DateTime.now();
  List<Routine> routines = [];

  @override
  void initState() {
    super.initState();
    fetchRoutinesForDate(_selectedDate);
  }

  void fetchRoutinesForDate(DateTime date) {
    final CollectionReference routineCollection =
        FirebaseFirestore.instance.collection('routines');
    final Timestamp startOfDay =
        Timestamp.fromDate(DateTime(date.year, date.month, date.day));

    routineCollection
        .where('date', isGreaterThanOrEqualTo: startOfDay)
        .where('date',
            isLessThan: Timestamp.fromDate(date.add(Duration(days: 1))))
        .get()
        .then((QuerySnapshot querySnapshot) {
      List<Routine> routinesList = [];
      querySnapshot.docs.forEach((doc) {
        routinesList
            .add(Routine.fromMap(doc.id, doc.data() as Map<String, dynamic>));
      });
      setState(() {
        routines = routinesList;
      });
      // Print routines to verify if data is fetched
      print("Fetched routines: $routines");
    }).catchError((error) {
      print('Error fetching routines: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
        ),
        title: Text(
          'Start Workout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      DateFormat.yMMMMd().format(DateTime.now()),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 5,
              left: 5,
            ),
            child: DatePicker(
              DateTime.now(),
              height: 90,
              width: 70,
              initialSelectedDate: DateTime.now(),
              selectionColor: const Color.fromARGB(255, 106, 179, 238),
              selectedTextColor: Colors.black,
              dateTextStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              dayTextStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              monthTextStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              onDateChange: (date) {
                _selectedDate = date;
                fetchRoutinesForDate(date);
              },
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              'My Routine',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: routines.length,
              itemBuilder: (context, index) {
                final routine = routines[index];
                return GestureDetector(
                  onTap: () {
                    print('Fetched Routine ID: ${routine.id}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DisplayRoutine(routineId: routine.id),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white54,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white12,
                            blurRadius: 2,
                            offset: Offset(2, 2),
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              routine.routineName,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              'Start Time: ${routine.startTime}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: floatingActionBtn(),
    );
  }

  Widget floatingActionBtn() {
    return Align(
      alignment: Alignment.bottomRight,
      child: FloatingActionButton(
        child: Container(
          width: 100,
          height: 100,
          child: const Icon(
            Icons.add,
            size: 30,
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                HexColor("ED6184"),
                HexColor("EF315B"),
                HexColor("E2042D"),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: const [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CreateRoutine()),
          );
        },
      ),
    );
  }
}

class Routine {
  final String id;
  final String routineName;
  final String startTime;

  Routine({
    required this.id,
    required this.routineName,
    required this.startTime,
  });

  factory Routine.fromMap(String id, Map<String, dynamic> map) {
    return Routine(
      id: id,
      routineName: map['routineName'] ?? '',
      startTime: map['startTime'] ?? '',
    );
  }
}
