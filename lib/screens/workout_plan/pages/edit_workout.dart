import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/components/my_bottom_nav_bar.dart';
import 'package:fitness/constants.dart';
import 'package:fitness/screens/workout_plan/pages/display_a_routine.dart';
import 'package:fitness/screens/workout_plan/pages/workout_home_page.dart';
import 'package:fitness/screens/workout_plan/widget/text_field.dart';
import 'package:flutter/material.dart';

class EditWorkout extends StatefulWidget {
  final String routineId;
  final int exerciseIndex;
  const EditWorkout(
      {Key? key, required this.routineId, required this.exerciseIndex})
      : super(key: key);

  @override
  _EditWorkoutState createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
  TextEditingController nameController = TextEditingController();
  TextEditingController setsController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch the exercise details when the widget is initialized
    fetchExerciseDetails();
  }

  void fetchExerciseDetails() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference routineCollection =
        firestore.collection('routines');

    routineCollection.doc(widget.routineId).get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        final List<dynamic>? exercises = (documentSnapshot.data()
            as Map<String, dynamic>?)?['exercises'] as List<dynamic>?;

        final Map<String, dynamic> exercise =
            (exercises?[widget.exerciseIndex] as Map<String, dynamic>?) ?? {};

        if (exercises != null) {
          if (widget.exerciseIndex >= 0 &&
              widget.exerciseIndex < exercises.length) {
            final Map<String, dynamic>? exercise =
                exercises[widget.exerciseIndex] as Map<String, dynamic>?;

            if (exercise != null) {
              setState(() {
                nameController.text = exercise['exercise name'] ?? '';
                setsController.text = exercise['sets'] ?? '';
                repsController.text = exercise['reps'] ?? '';
                timeController.text = exercise['time'] ?? '';
              });
            }
          }
        }
      } else {
        // Handle the case where the document with the given ID doesn't exist
        print('Routine with ID ${widget.routineId} does not exist.');
      }
    }).catchError((error) {
      print('Error fetching routine details: $error');
    });
  }

  void updateExerciseDetails() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference routineCollection =
        firestore.collection('routines');

    final String name = nameController.text;
    final String sets = setsController.text;
    final String reps = repsController.text;
    final String time = timeController.text;

    routineCollection.doc(widget.routineId).get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        final List<dynamic>? exercises = (documentSnapshot.data()
            as Map<String, dynamic>?)?['exercises'] as List<dynamic>?;

        if (exercises != null) {
          if (widget.exerciseIndex >= 0 &&
              widget.exerciseIndex < exercises.length) {
            final Map<String, dynamic>? exercise =
                exercises[widget.exerciseIndex] as Map<String, dynamic>?;

            if (exercise != null) {
              exercise['exercise name'] = name;
              exercise['sets'] = sets;
              exercise['reps'] = reps;
              exercise['time'] = time;

              // Update the exercise details in Firestore
              routineCollection.doc(widget.routineId).update({
                'exercises': exercises,
              }).then((value) {
                print('Exercise details updated successfully.');
                //Navigator.pop(context, true);
                // You can add a snackbar or navigate back to the previous screen
              }).catchError((error) {
                print('Error updating exercise details: $error');
              });
            }
          }
        }
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutHomePage(),
      ),
    );
  }

  void deleteExercise() {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference routineCollection =
        firestore.collection('routines');

    routineCollection.doc(widget.routineId).get().then((documentSnapshot) {
      if (documentSnapshot.exists) {
        final List<dynamic>? exercises = (documentSnapshot.data()
            as Map<String, dynamic>?)?['exercises'] as List<dynamic>?;

        if (exercises != null) {
          if (widget.exerciseIndex >= 0 &&
              widget.exerciseIndex < exercises.length) {
            exercises.removeAt(widget.exerciseIndex);

            // Update the exercise list in Firestore to remove the exercise
            routineCollection.doc(widget.routineId).update({
              'exercises': exercises,
            }).then((value) {
              print('Exercise deleted successfully.');
              //Navigator.pop(context, true);
              // You can add a snackbar or navigate back to the previous screen
            }).catchError((error) {
              print('Error deleting exercise: $error');
            });
          }
        }
      }
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutHomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        title: Text(
          'Edit Workout',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  height: 52,
                  margin:
                      EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
                  padding: EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.transparent, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    ' Exercise : ${nameController.text}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 227, 189, 1),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                // TextField(
                //   controller: nameController,
                //   decoration: InputDecoration(
                //     hintText: 'Enter exercise name',
                //   ),
                //   style: TextStyle(
                //     fontSize: 18,
                //     color: Colors.white,
                //   ),
                // ),

                Container(
                  height: 52,
                  margin:
                      EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
                  padding: EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'No.of Sets  :       ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: setsController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '12',
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 52,
                  margin:
                      EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
                  padding: EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'No.of reps  :      ',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: repsController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '12',
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 52,
                  margin:
                      EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
                  padding: EdgeInsets.only(left: 14),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Time           :',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: TextField(
                          controller: timeController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: '20',
                          ),
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 170),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: updateExerciseDetails,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        backgroundColor: Color.fromARGB(255, 227, 189, 1),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 50.0,
                        ),
                      ),
                      child: Text(
                        'Update',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: deleteExercise,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 50.0,
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
