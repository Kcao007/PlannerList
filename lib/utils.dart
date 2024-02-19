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

snackBarBuilder(String message, BuildContext context) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Map startEndDate(value) {
  DateTime currentDate = DateTime.now();
  DateTime startDate;
  DateTime endDate;

  switch(value) {
    case "Day":
      startDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
      endDate = startDate.add(const Duration(days: 1));
      break;

    case "Week":
      int daysUntilSunday = DateTime.sunday - currentDate.weekday;
      int daysUntilSaturday = DateTime.saturday - currentDate.weekday;

      if(daysUntilSunday == 0) {
        startDate = currentDate;
      }

      else {
        startDate = currentDate.subtract(Duration(days: daysUntilSunday + 1));
      }
      endDate = currentDate.subtract(Duration(days: daysUntilSaturday + 1));

      break;

    default:
      throw Exception("Invalid date ranges");
  }

  return{"startDate" : startDate, "endDate" : endDate};
}