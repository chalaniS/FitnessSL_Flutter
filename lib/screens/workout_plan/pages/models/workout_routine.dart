class Exercise {
  final String exerciseName;
  final int sets;
  final int reps;
  final int time;

  Exercise({
    required this.exerciseName,
    required this.sets,
    required this.reps,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return {
      'exerciseName': exerciseName,
      'sets': sets,
      'reps': reps,
      'time': time,
    };
  }
}

class WorkoutRoutine {
  final String routineName;
  final DateTime date;
  final String startTime;
  final List<Map<String, dynamic>> exercises;

  WorkoutRoutine({
    required this.routineName,
    required this.date,
    required this.startTime,
    required this.exercises,
  });

  Map<String, dynamic> toMap() {
    return {
      'routineName': routineName,
      'date': date,
      'startTime': startTime,
      'exercises': exercises,
    };
  }
}
