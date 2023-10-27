import 'package:fitness/constants.dart';
import 'package:fitness/screens/workout_plan/pages/create_routine.dart';
import 'package:fitness/screens/workout_plan/pages/edit_workout.dart';
import 'package:fitness/screens/workout_plan/pages/timer_page.dart';
import 'package:fitness/screens/workout_plan/pages/workout_home_page.dart';
import 'package:flutter/material.dart';
import 'package:fitness/screens/workout_plan/widget/input_field.dart';

class DisplayRoutine extends StatefulWidget {
  const DisplayRoutine({Key? key, required String routineId}) : super(key: key);

  @override
  State<DisplayRoutine> createState() => _DisplayRoutineState();
}

class _DisplayRoutineState extends State<DisplayRoutine> {
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
          'Display Routine',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          // Navigate to the edit workout page here
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                // Replace 'EditWorkoutPage' with the actual name of your edit workout page
                return EditWorkout();
              },
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color.fromARGB(255, 210, 204, 204), width: 2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Exercise Name',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey.shade200,
                        ),
                        Row(
                          children: [
                            Text('sets'),
                            Text('reps'),
                            Text('time'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
