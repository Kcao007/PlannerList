import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:coding_minds_sample/firebase/db.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userUID = FirebaseAuth.instance.currentUser!.uid;
  List toDoTask = [];

  @override
  void initState () {
    super.initState();
    Future.delayed(Duration.zero, () {
      getMyInfo().then((value) {
        if (value == null) {
          showMyDialog();
        }

        else {
          getLogs();
        }

      });
    });

  }

  getLogs() async {
    getMyInfo().then((value) {
      setState(() {
        if(value != null && value.containsKey("Schedule")) {
          toDoTask = value["Schedule"];
        }
      });
    });
  }

  //prompts user to add user info to profile consistently
  Future<void> showMyDialog() async {
    showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Update Profile'),
        content: const Text('Before using the app, please visit the profile tab and submit user info.'),
        actions: [
          TextButton(onPressed: () {
            Navigator.of(context).pop();
          }, child: const Text('OK'))
        ],);
    },);
  }

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
                child: const Card(
                  color: Colors.white60,
                  child: Padding(
                    padding: EdgeInsets.all(8),
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

      //generate schedule button
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,

        children: <Widget>[
          FloatingActionButton.extended(
            onPressed: () {
              showDateTimePicker(context);
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

  void showDateTimePicker(BuildContext context) async {
    DateTime date = DateTime.now();
    TimeOfDay time = TimeOfDay.now();

    //popup for choosing date/time to generate schedule for
    await showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Select your date and time: "),
        content: StatefulBuilder(
          builder: (context, setState) {

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                //date
                ListTile(
                  title: Text("Date: "),
                  subtitle: Text("${date.month}/${date.day}/${date.year}"),

                  onTap: () async {
                    DateTime? userDate = await showDatePicker(context: context,
                        firstDate: DateTime(date.year, date.month - 6, 1),
                        lastDate: DateTime(date.year, date.month + 6, 1),
                        initialDate: date);

                    if(userDate != null && userDate != date) {
                      setState(() {
                        date = userDate;
                      });
                    } // if

                  },
                ),

                //time
                ListTile(
                  title: Text("Time: "),
                  subtitle: Text("${time.format(context)}"),

                  onTap: () async {
                    TimeOfDay? userTime = await showTimePicker(context: context, initialTime: time);

                    if(userTime != null && userTime != time) {
                      setState(() {
                        time = userTime;
                      });
                    }
                  }
                )
              ]
            );
          }
        ),


      );
    });
  }
}