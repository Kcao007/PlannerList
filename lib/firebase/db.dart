import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_minds_sample/firebase/authentication.dart';
import 'package:coding_minds_sample/utils.dart';


String collection = "users";
String uid = AuthenticationHelper().getUID();

//gets the user's info from their user ID
Future<Map?> getUserInfo (String uid) async{
  Map? data;
  await FirebaseFirestore.instance
    .collection(collection)
    .doc(uid)
    .get()
    .then(
      (DocumentSnapshot doc) {
        if (doc.exists) {
          data = doc.data() as Map?;
        }

        else {
          print("Document does not exist");
          return null;
        }
    },
  );
  return data;
}

//gets the current user's info using getUserInfo
Future<Map?> getMyInfo() async {
  Map? data = await getUserInfo(uid);
  return data;
}

//updates user info based off of changes made to profile.dart
Future<bool> editUserInfo (Map<String, dynamic> data) async {
  FirebaseFirestore.instance
    .collection(collection)
    .doc(uid)
    .set(data, SetOptions(merge: true));

  return true;
}

//gets user's taskLog from their data
Future<List> getTaskLog(String uid) async {
  List log = [];
  await getUserInfo(uid).then((value) {
    try {
      List tempList = value!["taskLog"];
      log = tempList;
    }

    catch (e) {
      print("error: " + e.toString());
    }
  });

  return log;
}

//gets current user's taskLog using getTaskLog
Future<List> getMyTaskLog() async {
  List log = [];
  String uid = AuthenticationHelper().uid;
  log = await getTaskLog(uid);
  return log;

  // List data = await getTaskLog(uid);
  //
  // return data;
}

//adds to taskLog
Future<bool> addTaskLog(Map data) async {
    List taskLog = await getTaskLog(uid);
    taskLog.add(data);
    updateTaskLog(taskLog);
    return true;
}

//overwrites taskLog with List tasks
Future<bool> updateTaskLog(List tasks) async {
  FirebaseFirestore.instance
    .collection(collection)
    .doc(uid)
    .update({"taskLog": tasks});

  return true;
}

//sorts TaskLog based on task date by calling insertionSort Tasks and then overwriting the old taskLog with updateTaskLog
Future<void> sortTaskLog() async {
  List taskLog = await getTaskLog(uid);

  insertionSortTasks(taskLog);
  updateTaskLog(taskLog);

}

Future<Map<String, dynamic>> getUserRankDate(String range) async {
  Map<String, dynamic> rank = {};
  double percentDone = 0;

  Map date = startEndDate(range);
  DateTime startDate = date["startDate"];
  DateTime endDate = date["endDate"];

  await FirebaseFirestore
    .instance
    .collection(collection)
    .get()
    .then((query) {

      for(var uid in query.docs) {
        print(uid.id);
        Map<String, dynamic> data = uid.data();

        if(data.containsKey("taskLog") && data["taskLog"].length != null) {
          List taskLog = data["taskLog"];
          int completed = 0;
          int tasks = 0;

          for(Map<String, dynamic> task in taskLog) {
            Map<String, dynamic> element = task;
            DateTime taskDate = DateTime.parse(element["taskDate"]);

            if(taskDate.isBefore(endDate) && taskDate.isAfter(startDate) || taskDate.isAtSameMomentAs(startDate)) {
              tasks++;

              if(element["taskDone"] == true) {
                completed++;
              } //if
            } //if
            rank[data['nickname']] = (completed / tasks * 100).toStringAsFixed(0);

          } //for
          print(rank);

        } //if
        else {
          return {data["nickname"], 0};
        }
      } //for
  }); //.then

  return rank;
}