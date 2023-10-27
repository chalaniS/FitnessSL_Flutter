import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/constants.dart';
import 'package:fitness/screens/workout_plan/pages/workout_home_page.dart';
import 'package:fitness/screens/workout_plan/widget/input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

class CreateRoutine extends StatefulWidget {
  const CreateRoutine({Key? key}) : super(key: key);

  @override
  State<CreateRoutine> createState() => _CreateRoutineState();
}

class _CreateRoutineState extends State<CreateRoutine> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  int exerciseCount = 1;
  List<Exercise> exercises = [];
  String routineName = '';

  Future<void> saveWorkoutRoutine() async {
    try {
      final CollectionReference routineCollection =
          _firestore.collection('routines'); // Use the _firestore instance
      await routineCollection.add({
        'routineName': routineName,
        'date': _selectedDate,
        'startTime': _startTime,
        'exercises': exercises
            .where((exercise) => exercise.name.isNotEmpty)
            .map((exercise) {
          return {
            'exercise name': exercise.name,
            'sets': exercise.sets,
            'reps': exercise.reps,
            'time': exercise.time
          };
        }).toList(),
      });
      print("Routine data saved successfully!");
    } catch (e) {
      print('Error saving workout routine: $e');
    }
  }

  void addExercise() {
    setState(() {
      exercises.add(Exercise(name: '', sets: '', reps: '', time: ''));
    });
  }

  Future<void> _getDateFromUser() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _showTimePicker() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 10),
    );

    if (pickedTime != null) {
      setState(() {
        _startTime = _formatTimeOfDay(pickedTime);
      });
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final now = DateTime.now();
    final DateTime dateTime =
        DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dateTime);
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
            );
          },
        ),
        title: Text(
          'Create Routine',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Form(
        key: _formKey, // Associate the _formKey with the Form widget
        child: Container(
          margin: EdgeInsets.all(15),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                MyInputField(
                  title: 'Routine Name',
                  hint: 'Enter Routine Name',
                  onChanged: (String routineName) {
                    setState(() {
                      this.routineName = routineName;
                    });
                  },
                  validator: (routineName) {
                    if (routineName == null || routineName.isEmpty) {
                      return 'Please enter routine Name';
                    }
                    return null;
                  },
                ),
                Row(
                  children: [
                    Expanded(
                      child: MyInputField(
                        title: 'Date',
                        hint: DateFormat.yMd().format(_selectedDate),
                        widget: IconButton(
                          icon: Icon(
                            Icons.calendar_today_outlined,
                            color: Colors.grey,
                          ),
                          onPressed: _getDateFromUser,
                        ),
                        onChanged:
                            (String value) {}, // Dummy onChanged function
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a date';
                          }
                          DateTime selectedDate = DateFormat.yMd().parse(value);
                          DateTime currentDate = DateTime.now();

                          if (selectedDate.isBefore(currentDate)) {
                            return 'Date must be in the future';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: MyInputField(
                        title: 'Start Time',
                        hint: _startTime,
                        widget: IconButton(
                          icon: Icon(
                            Icons.access_time_rounded,
                            color: Colors.grey,
                          ),
                          onPressed: _showTimePicker,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a valid start time';
                          }
                          return null;
                        },
                        onChanged: (String value) {},
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: exercises.length,
                  itemBuilder: (context, index) {
                    final exercise = exercises[index];
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: MyInputField(
                                title: 'Exercise Name',
                                hint: 'Enter name of Exercise',
                                onChanged: (String name) {
                                  exercise.name = name;
                                },
                                validator: (name) {
                                  if (name == null || name.isEmpty) {
                                    return 'Please enter exercise name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: MyInputField(
                                title: 'sets',
                                hint: '3',
                                onChanged: (String sets) {
                                  exercise.sets = sets;
                                },
                                validator: (sets) {
                                  if (sets == null || sets.isEmpty) {
                                    return 'Please enter the number of sets';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: MyInputField(
                                title: 'reps',
                                hint: '12',
                                onChanged: (String reps) {
                                  exercise.reps = reps;
                                },
                                validator: (reps) {
                                  if (reps == null || reps.isEmpty) {
                                    return 'Please enter the number of reps';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: MyInputField(
                                title: 'time',
                                hint: '20',
                                onChanged: (String time) {
                                  exercise.time = time;
                                },
                                validator: (time) {
                                  if (time == null || time.isEmpty) {
                                    return 'Please enter the time for exercise';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  },
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: addExercise,
                        child: Text('Add Exercise'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blueGrey),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            saveWorkoutRoutine().then((_) {
                              print('Data saved');
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WorkoutHomePage(),
                                ),
                              );
                            });
                          }
                        },
                        child: Text('Submit'),
                      ),
                    ],
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

class Exercise {
  String name;
  String sets;
  String reps;
  String time;

  Exercise({
    required this.name,
    required this.sets,
    required this.reps,
    required this.time,
  });
}
