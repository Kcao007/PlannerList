import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coding_minds_sample/firebase/authentication.dart';

String collection = "users";

Future<Map?>getUserInfo (String uid) async{
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
}

Future<Map?>getMyInfo () async {
  Map? data;
  String uid = AuthenticationHelper().uid;
  data = await getUserInfo(uid);
  return data;
}