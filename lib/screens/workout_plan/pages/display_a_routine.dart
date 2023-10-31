import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/constants.dart';
import 'package:fitness/screens/workout_plan/pages/create_routine.dart';
import 'package:fitness/screens/workout_plan/pages/edit_workout.dart';
import 'package:fitness/screens/workout_plan/pages/timer_page.dart';
import 'package:fitness/screens/workout_plan/pages/workout_home_page.dart';
import 'package:flutter/material.dart';
import 'package:fitness/screens/workout_plan/widget/input_field.dart';

class DisplayRoutine extends StatefulWidget {
  final String routineId;

  const DisplayRoutine({Key? key, required this.routineId}) : super(key: key);

  @override
  State<DisplayRoutine> createState() => _DisplayRoutineState();
}

class _DisplayRoutineState extends State<DisplayRoutine> {
  String routineName = '';
  List<Exercise> exercises = [];

  @override
  void initState() {
    super.initState();
    // Fetch routine details when the widget is initialized
    fetchRoutineDetails();
  }

  void fetchRoutineDetails() {
    final CollectionReference routineCollection =
        FirebaseFirestore.instance.collection('routines');

    // Use the provided routineId to get the specific routine
    routineCollection.doc(widget.routineId).get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>;
        // Get routine details from the document
        setState(() {
          routineName = data['routineName'];
          exercises = (data['exercises'] as List<dynamic>)
              .map((exercise) => Exercise(
                    name: exercise['exercise name'],
                    sets: exercise['sets'],
                    reps: exercise['reps'],
                    time: exercise['time'],
                  ))
              .toList();
        });
      } else {
        // Handle the case where the document with the given ID doesn't exist
        print('Routine with ID ${widget.routineId} does not exist.');
      }
    }).catchError((error) {
      print('Error fetching routine details: $error');
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
              MaterialPageRoute(builder: (context) => WorkoutHomePage()),
            ); // Navigate back when the back arrow is pressed
          },
        ),
        title: Text(
          'Routine : $routineName',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            final exercise = exercises[index];
            return GestureDetector(
              onTap: () {
                print('Tapped container at index: $index');
                // Navigate to the edit workout page here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      // Replace 'EditWorkoutPage' with the actual name of your edit workout page
                      return EditWorkout(
                          routineId: widget.routineId, exerciseIndex: index);
                    },
                  ),
                );
              },
              child: Container(
                width: 300, // Set the width to your desired fixed width
                height: 160, // Set the height to your desired fixed height
                margin:
                    EdgeInsets.all(5), // Set a fixed margin of 20 for all sides
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 227, 189, 1),
                    width: 2,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${exercise.name}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                                  FontWeight.bold // Increase the font size
                              ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TimerPage(
                                  index: index,
                                  name: exercise.name,
                                  time: exercise.time,
                                  exerciseList: exercises,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.play_circle_outline, // Add your desired icon
                            color: Color.fromARGB(255, 227, 189,
                                1), // Change the icon color as needed
                          ),
                        ),
                        Icon(
                          Icons.edit, // Add your desired icon
                          color:
                              Colors.white, // Change the icon color as needed
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Divider(
                        thickness: 1.5,
                        color: Color.fromARGB(255, 227, 189, 1)),
                    Text(
                      'No.of Sets  : ${exercise.sets}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Increase the font size
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'No.of Reps : ${exercise.reps}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Increase the font size
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Time spent : ${exercise.time}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18, // Increase the font size
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
