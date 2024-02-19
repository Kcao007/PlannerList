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

    default:
      throw Exception("Invalid date ranges");
  }

  return{"startDate" : startDate, "endDate" : endDate};
}