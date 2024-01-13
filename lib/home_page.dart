import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userUID = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),

      body: Padding(
        padding: const EdgeInsets.all(12),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Text('Today\'s Schedule', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),

              SizedBox(
                height: height * 0.6,
                width: width,
                child: Card(
                  color: Colors.white60,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SingleChildScrollView(
                      child: Column(

                      )
                    )
                  )
                )
              ),
            ],
          ),
        ),

      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: <Widget>[
          FloatingActionButton.extended(
            onPressed: () {

            },
            label: const Text('Generate \nSchedule', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            icon: const Icon(Icons.alarm_add),
          ),

          const SizedBox(
            height: 20,
          ),
        ]
      )


    );
  }
}

//            Text("UID: " + userUID, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),