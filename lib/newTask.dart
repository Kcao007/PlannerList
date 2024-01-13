import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {

  final nameController = TextEditingController();
  final timeController = TextEditingController();
  final descriptionController = TextEditingController();

  final List<String> priority = <String>['highest', 'high', 'medium', 'low', 'lowest'];
  final List<int> day = <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30];
  final List<String> month = <String>['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
  final List<String> type = <String>['Practice', 'Chores', 'School', 'Lesson', 'Other'];

  @override
  Widget build(BuildContext context) {

    String dropDownValue = priority.first;
    int dropDownDay = day.first;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("New Task"),
      ),
      //task name, task date, task time, task type, task difficulty/priority, task description

      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children:[

            const SizedBox(
              height : 10,
            ),

            const Text('New Task', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),

            Container(
                height : 3,
                width: 350,
                color: Colors.black
            ),

            const SizedBox(
              height : 15,
            ),
g
            SizedBox(
              width: 350,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Name',
                ),
                controller: nameController,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Task Type', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

                const SizedBox(
                  width: 10,
                ),

                DropdownMenu<String>(
                  width: 225,
                  initialSelection: type.first,
                  onSelected: (String? value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  },
                  dropdownMenuEntries: type.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Date', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

                const SizedBox(
                  width: 10,
                ),

                DropdownMenu<int>(
                  width: 100,
                  initialSelection: day.first,
                  onSelected: (int? value) {
                    setState(() {
                      dropDownDay = value!;
                    });
                  },
                  dropdownMenuEntries: day.map<DropdownMenuEntry<int>>((int value) {
                    return DropdownMenuEntry<int>(value: value, label: day.elementAt(value - 1).toString());
                  }).toList(),
                ),

                const SizedBox(
                  width: 10,
                ),

                DropdownMenu<String>(
                  width: 175,
                  initialSelection: month.first,
                  onSelected: (String? value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  },
                  dropdownMenuEntries: month.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 350,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Time Allotted',
                ),
                controller: timeController,
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Priority', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

                const SizedBox(
                  width: 10,
                ),

                DropdownMenu<String>(
                  width: 255,
                  initialSelection: priority.first,
                  onSelected: (String? value) {
                    setState(() {
                      dropDownValue = value!;
                    });
                  },
                  dropdownMenuEntries: priority.map<DropdownMenuEntry<String>>((String value) {
                    return DropdownMenuEntry<String>(value: value, label: value);
                  }).toList(),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            SizedBox(
              width: 350,
              child: TextField(
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Task Description (Optional)',
                ),
                controller: descriptionController,
              ),
            ),

          ],
        )
      )
    );
  }
}
