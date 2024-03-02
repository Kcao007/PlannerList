import 'package:flutter/material.dart';

buildLoading(BuildContext context) {
  return showDialog(context: context, barrierDismissible: false, builder: (BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
              Colors.blue
          ),
        )
    );
  });
}

//builds a notification on the bottom of the screen
snackBarBuilder(String message, BuildContext context) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

//calculates the start and end dates for ranking and task pages
Map startEndDate(value) {
  DateTime currentDate = DateTime.now();
  DateTime startDate;
  DateTime endDate;

  switch(value) {
    case "Day":
      //calculates the current day and sets the end day as the next day
      startDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
      endDate = startDate.add(const Duration(days: 1));
      break;

    case "Week":
      //finds the number of days until sunday and saturday
      int daysUntilSunday = DateTime.sunday - currentDate.weekday;
      int daysUntilSaturday = DateTime.saturday - currentDate.weekday;

      //if the week has just started ie: today is sunday, set the startDate as today
      if(daysUntilSunday == 0) {
        startDate = currentDate;
      }

      //otherwise calculate the days since last Sunday till next Saturday
      else {
        startDate = currentDate.subtract(Duration(days: 7 - daysUntilSunday + 1));
      }
      endDate = currentDate.add(Duration(days: daysUntilSaturday + 1));
      break;

    case "Month":
      startDate = DateTime(currentDate.year, currentDate.month, 1);
      endDate = DateTime(currentDate.year, currentDate.month + 1, 1);
      break;

    default:
      throw Exception("Invalid date ranges");
  }

  return{"startDate" : startDate, "endDate" : endDate};
}

//method for adding together the hours and minutes values from creating a new task
String convertTime(TextEditingController hours, TextEditingController minutes) {
  double numHours = double.parse(hours.text.trim());
  double numMinutes = double.parse(minutes.text.trim());

  return (numHours + (numMinutes / 60)).toStringAsFixed(2);
}

//simple insertion sort algorithm for sorting tasks by date by comparing them using .isAfter()
insertionSortTasks(List taskList) {
  int j;
  Map<String, dynamic> temp;

  for(int i = 0; i < taskList.length; i++) {
    DateTime taskDate = DateTime.parse(taskList[i]["taskDate"]);
    temp = taskList[i];
    j = i - 1;

    while (j >= 0 && DateTime.parse(taskList[j]["taskDate"]).isAfter(taskDate)) {

      taskList[j + 1] = taskList[j];
      j -= 1;
    }

    taskList[j + 1] = temp;
  }
}