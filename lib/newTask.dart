import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {

  final nameController = TextEditingController();
  final hoursController = TextEditingController();
  final minutesController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  final List<String> priority = <String>['highest', 'high', 'medium', 'low', 'lowest'];
  final List<String> type = <String>['Practice', 'Chores', 'School', 'Lesson', 'Other'];

  bool showCalendar = false;

  @override
  Widget build(BuildContext context) {

    String dropDownValue = priority.first;

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
                const Text('Task Type:', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

                const SizedBox(
                  width: 10,
                ),

                DropdownMenu<String>(
                  width: 215,
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
                const Text('Date:', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

                const SizedBox(
                  width: 10,
                ),

                SizedBox(
                  width: 250,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Task Date',
                    ),
                    controller: dateController,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                IconButton(onPressed: () {
                  setState(() {
                    if(dateController.text.isEmpty) {
                      dateController.text = DateTime.now().toString().substring(0, 10);
                    }
                    showCalendar = !showCalendar;
                  });
                }, icon: const Icon(Icons.calendar_month_rounded)),

              ],
            ),

            showCalendar
              ?SizedBox(
              height: 100,
              child: CupertinoDatePicker(mode: CupertinoDatePickerMode.date, initialDateTime: DateTime.now(),
              onDateTimeChanged: (DateTime newDateTime) {
                setState(() {
                  dateController.text = newDateTime.toString().substring(0, 10);
                });
              },)
            ):
              const SizedBox(),

            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Duration:', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

                const SizedBox(
                  width: 10,
                ),

                SizedBox(
                  width: 110,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Hours',
                    ),
                    controller: hoursController,
                  ),
                ),

                const SizedBox(
                  width: 10,
                ),

                SizedBox(
                  width: 110,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Minutes',
                    ),
                    controller: minutesController,
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 10,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Priority:', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

                const SizedBox(
                  width: 10,
                ),

                DropdownMenu<String>(
                  width: 247,
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
