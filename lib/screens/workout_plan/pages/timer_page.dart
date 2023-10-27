import 'dart:async';
import 'package:fitness/constants.dart';
import 'package:fitness/screens/workout_plan/components/buttons.dart';
import 'package:fitness/screens/workout_plan/pages/create_routine.dart';
import 'package:fitness/screens/workout_plan/pages/display_a_routine.dart';
import 'package:fitness/screens/workout_plan/pages/progress_page.dart';
import 'package:fitness/screens/workout_plan/pages/workout_home_page.dart';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  final String time;
  final String name;
  final int index;
  final List<Exercise> exerciseList;

  const TimerPage({
    Key? key,
    required this.time,
    required this.name,
    required this.index,
    required this.exerciseList,
  }) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  late int maxSeconds;
  String name = '';
  int seconds = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    maxSeconds = int.parse(widget.time);
    name = widget.name;
    seconds = maxSeconds;
  }

  String getNextExerciseName() {
    final int currentIndex = widget.index;
    if (currentIndex < widget.exerciseList.length - 1) {
      return widget.exerciseList[currentIndex + 1].name;
    } else {
      return 'No more exercises';
    }
  }

  void resetTimer() => setState(() => seconds = maxSeconds);

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
    });
  }

  void showCompletionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: darkBlue, // Set the background color to dark blue
          title: Text(
            "Congratulations!",
            style: TextStyle(
              color: Colors.white, // Set the text color to white
              fontSize: 24, // Increase the font size
            ),
          ),
          content: Text(
            "You are near to your goal.",
            style: TextStyle(
              color: Colors.white, // Set the text color to white
              fontSize: 18, // Increase the font size
            ),
          ),
          contentPadding: EdgeInsets.all(20), // Add padding to the content
          contentTextStyle: TextStyle(
            color: Colors.white, // Set the text color of the content to white
            fontSize: 18, // Increase the font size of the content
          ),
          actions: <Widget>[
            TextButton(
              child: Text("OK",
                  style: TextStyle(
                    color: Color.fromARGB(
                        255, 227, 189, 1), // Set the button color to yellow
                    fontSize: 18, // Increase the font size
                  )),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WorkoutHomePage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    timer?.cancel();
    if (!reset && getNextExerciseName() == 'No more exercises') {
      showCompletionDialog();
    }
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
              MaterialPageRoute(
                builder: (context) => DisplayRoutine(
                  routineId: 'routineId',
                ),
              ),
            );
          },
        ),
        title: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(40),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get Ready For ${getNextExerciseName()}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 26,
                ),
              ),
              SizedBox(
                height: 60,
              ),
              buildTime(),
              SizedBox(
                height: 80,
              ),
              buildButton(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(),
    );
  }

  Widget buildButton() {
    final isRunning = timer == null ? false : timer!.isActive;
    final isCompleted = seconds == maxSeconds || seconds == 0;
    return isRunning || !isCompleted
        ? Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonWidget(
                  text: isRunning ? 'Pause' : 'Resume',
                  onClicked: () {
                    if (isRunning) {
                      stopTimer(reset: false);
                    } else {
                      startTimer(reset: false);
                    }
                  },
                ),
                const SizedBox(width: 20),
                ButtonWidget(
                  text: 'Cancel',
                  onClicked: () {
                    stopTimer();
                  },
                ),
              ],
            ),
          )
        : ButtonWidget(
            text: 'Start Timer',
            onClicked: () {
              startTimer();
            },
          );
  }

  Widget buildTime() => SizedBox(
        width: 200,
        height: 200,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: seconds / maxSeconds,
              strokeWidth: 12,
              color: Color.fromARGB(255, 227, 189, 1),
            ),
            Center(
              child: buildTimeText(),
            ),
          ],
        ),
      );

  Widget buildTimeText() {
    return Text(
      '$seconds',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Color.fromARGB(255, 227, 189, 1),
        fontSize: 70,
      ),
    );
  }
}
