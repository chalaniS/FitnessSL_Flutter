import 'package:fitness/screens/workout_plan/pages/create_routine.dart';
import 'package:flutter/material.dart';
import 'package:fitness/screens/workout_plan/utils/colors_util.dart';
import 'package:fitness/screens/workout_plan/utils/date_utils.dart'
    as date_utils;

class WorkoutPlanPage extends StatefulWidget {
  const WorkoutPlanPage({super.key});

  @override
  State<WorkoutPlanPage> createState() => _WorkoutPlanPageState();
}

class _WorkoutPlanPageState extends State<WorkoutPlanPage> {
  @override
  void initState() {
    super.initState();
    currentMonthList = date_utils.DateUtils.daysInMonth(currentDateTime);
    currentMonthList = currentMonthList.toSet().toList();
    scrollController =
        ScrollController(initialScrollOffset: 70.0 * currentDateTime.day);
  }

  double width = 0;
  double height = 0;
  late ScrollController scrollController;
  List<DateTime> currentMonthList = List.empty();
  DateTime currentDateTime = DateTime.now();
  List<String> todoList = <String>[];
  TextEditingController textController = TextEditingController();

  Widget topView() {
    return Container(
      height: height * 0.35,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [
              HexColor("488BC8").withOpacity(0.7),
              HexColor("488BC8").withOpacity(0.5),
              HexColor("488BC8").withOpacity(0.3)
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(0.0, 1.0),
            stops: const [0.0, 0.5, 1.0],
            tileMode: TileMode.clamp),
        boxShadow: const [
          BoxShadow(
              blurRadius: 4,
              color: Colors.black12,
              offset: Offset(4, 4),
              spreadRadius: 2)
        ],
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            titleView(),
            horizontalCapsuleListView(),
          ]),
    );
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Text(
        date_utils.DateUtils.months[currentDateTime.month - 1] +
            ' ' +
            currentDateTime.year.toString(),
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
        child: GestureDetector(
          onTap: () {
            setState(() {
              currentDateTime = currentMonthList[index];
            });
          },
          child: Container(
            width: 80,
            height: 140,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: (currentMonthList[index].day != currentDateTime.day)
                        ? [
                            Colors.white.withOpacity(0.8),
                            Colors.white.withOpacity(0.7),
                            Colors.white.withOpacity(0.6)
                          ]
                        : [
                            HexColor("ED6184"),
                            HexColor("EF315B"),
                            HexColor("E2042D")
                          ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(4, 4),
                    blurRadius: 4,
                    spreadRadius: 2,
                    color: Colors.black12,
                  )
                ]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    currentMonthList[index].day.toString(),
                    style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? HexColor("465876")
                                : Colors.white),
                  ),
                  Text(
                    date_utils.DateUtils
                        .weekdays[currentMonthList[index].weekday - 1],
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color:
                            (currentMonthList[index].day != currentDateTime.day)
                                ? HexColor("465876")
                                : Colors.white),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget horizontalCapsuleListView() {
    return Container(
      width: width,
      height: 150,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget todoListView() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, height * 0.38, 10, 10),
      width: width,
      height: height * 0.60,
      child: ListView.builder(
          itemCount: todoList.length,
          padding: EdgeInsets.zero,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              width: width - 20,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.white12,
                      blurRadius: 2,
                      offset: Offset(2, 2),
                      spreadRadius: 3)
                ],
              ),
              child: Center(
                child: Text(
                  todoList[index],
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
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
                      HexColor("E2042D")
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(0.0, 1.0),
                    stops: const [0.0, 0.5, 1.0],
                    tileMode: TileMode.clamp)),
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const CreateRoutine()),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          topView(),
          todoListView(),
        ],
      ),
      floatingActionButton: floatingActionBtn(),
    );
  }
}
