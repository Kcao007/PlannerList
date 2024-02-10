import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_minds_sample/firebase/authentication.dart';

String collection = "users";
String uid = AuthenticationHelper().getUID();

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

Future<Map?> getMyInfo() async {
  Map? data = await getUserInfo(uid);
  return data;
}

Future<bool> editUserInfo (Map<String, dynamic> data) async {
  FirebaseFirestore.instance
    .collection(collection)
    .doc(uid)
    .set(data, SetOptions(merge: true));

  return true;
}

//Adding Tasks

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

Future<List> getMyTaskLog() async {
  List data = await getTaskLog(uid);
  return data;
}

Future<bool> addTaskLog(Map data) async {
    List taskLog = await getTaskLog(uid);
    taskLog.add(data);
    FirebaseFirestore.instance
        .collection(collection)
        .doc(uid)
        .update({"taskLog": taskLog});

    return true;
}

