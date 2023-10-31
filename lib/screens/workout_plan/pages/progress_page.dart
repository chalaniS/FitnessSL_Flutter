import 'package:fitness/constants.dart';
import 'package:fitness/screens/workout_plan/pages/bar%20graph/bar_graph.dart';
import 'package:fitness/screens/workout_plan/pages/workout_home_page.dart';
import 'package:flutter/material.dart';

class Progresspage extends StatefulWidget {
  const Progresspage({Key? key});

  @override
  State<Progresspage> createState() => _ProgresspageState();
}

class _ProgresspageState extends State<Progresspage> {
  List<double> weeklySummary = [
    0.0,
    70.20,
    58.9,
    0.0,
    64.40,
    76.40,
    14.40,
  ];

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
          'Workout Progress',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 52,
            margin: EdgeInsets.only(left: 120, right: 120),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Week Report',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 300,
            child: BarGraphPage(
              weeklySummary: weeklySummary,
            ),
          ),
          // SizedBox(
          //   height: 20,
          // ),
          Container(
            height: 48,
            margin: EdgeInsets.only(top: 5, bottom: 5, right: 30, left: 30),
            padding: EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 227, 189, 1)),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                'Keep Going! Cheers! ',
                style: TextStyle(
                  fontSize: 22,
                  color: Color.fromARGB(255, 227, 189, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }
}
