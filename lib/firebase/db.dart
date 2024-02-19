import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_minds_sample/firebase/authentication.dart';
import 'package:coding_minds_sample/tasks.dart';
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

//updages user info based off of changes made to profile.dart
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
    FirebaseFirestore.instance
        .collection(collection)
        .doc(uid)
        .update({"taskLog": taskLog});

    return true;
}

//updates a task inside of taskLog
Future<bool> updateTaskLog(List tasks) async {
  String uid = AuthenticationHelper().uid;
  FirebaseFirestore.instance
      .collection(collection)
      .doc(uid)
      .update({"taskLog": tasks});

  return true;
}

Future<void> sortTaskLog() async {
  String uid = AuthenticationHelper().uid;
  List taskLog = await getMyTaskLog();

  insertionSortTasks(taskLog);
  updateTaskLog(taskLog);

}

