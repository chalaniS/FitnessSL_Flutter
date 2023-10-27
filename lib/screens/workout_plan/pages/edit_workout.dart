import 'package:fitness/components/my_bottom_nav_bar.dart';
import 'package:fitness/constants.dart';
import 'package:fitness/screens/workout_plan/widget/text_field.dart';
import 'package:flutter/material.dart';

class EditWorkout extends StatefulWidget {
  const EditWorkout({Key? key}) : super(key: key);

  @override
  _EditWorkoutState createState() => _EditWorkoutState();
}

class _EditWorkoutState extends State<EditWorkout> {
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
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40,
              ),
              Text(
                'Exercise Name',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              TextFieldPage(),
              Row(
                children: [
                  Text(
                    'No.of sets : ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                      child: TextFieldPage(
                    width: 100,
                  )),
                ],
              ),
              Row(
                children: [
                  Text(
                    'No.of reps : ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                      child: TextFieldPage(
                    width: 100,
                  )),
                ],
              ),
              Row(
                children: [
                  Text(
                    'Time : ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Expanded(
                    child: TextFieldPage(
                      width: 100,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 170),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
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
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
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
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
