import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TestingDBPage extends StatefulWidget {
  const TestingDBPage({super.key});

  @override
  State<TestingDBPage> createState() => _TestingDBPageState();
}

class _TestingDBPageState extends State<TestingDBPage> {

  final db = FirebaseFirestore.instance;
  var name;
  List allNames = [];
  final user = <String, dynamic> {
    'name' : "Bob",
    'email' : "Bob@gmail.com",
    'age' : 47,
  };

  @override
  void initState() {
    super.initState();
    //uploadData();
  }

  void uploadData() {
    db.collection("users").add(user);
  }

  void loadName() {
    final docRef = db.collection("users").doc('bH1kwaNe8hKkSRiLEcYB');
    docRef.get().then(
        (DocumentSnapshot doc) {
          final data = doc.data() as Map<String, dynamic>;
          name = data['name'];
          print(name);
        },
      onError: (e) => print("Error getting document: $e"),
    );
  }

  void loadAllNames() {
    allNames = [];
    db.collection('users').get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            allNames.add(docSnapshot.get('name'));
          }
          print("all names: " + allNames.toString());
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Testing Page"),
      ),
      body: Column(
        children: [
          TextField(
            decoration: const InputDecoration(helperText: "Name"),
            onSubmitted: (String submittedText) {
              final userInfo =<String, dynamic> {
                'name' : submittedText,
              };
              db.collection("users").add(userInfo); //add data to users collection
            },
          )
        ],
      )
    );
  }
}

/*

query multiple documents: (for example to ind everyone over age 21)
db.collection(users)
  .where(KEY, isEqualTo: Value);
  .get().then(
    (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          final data = docSnapshot.data();
      }
    },
    onError: (e) => print("Error completing: $e"),
  );

Updating documents:
final docRef = db.collection(COLLECTION_NAME).doc(DOCUMENT_ID);
docRef.update({"KEY" : NEW_VALUE}, {...});

deleting documents:
final docRef = db.collection(COLLECTION_NAME).doc(DOCUMENT_ID);
docRef.delete();

deleting specific fields: (for example deleting a task)

final deletion = <String, dynamic> {
  "FIELD_TO_DELETE" : FieldValue.delete();
  }
  docRef.update(deletion);

 */

// FutureBuilder with ListView
// For our tasks screen, shows a loading screen until db data is loaded in and shown to user