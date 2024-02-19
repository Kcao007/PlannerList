import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coding_minds_sample/firebase/db.dart';
import 'package:coding_minds_sample/utils.dart';
import 'package:coding_minds_sample/tasks.dart';

class NewTaskPage extends StatefulWidget {
  const NewTaskPage({super.key});

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {

  final taskNameController = TextEditingController();
  final hoursController = TextEditingController();
  final minutesController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();

  final List<String> priority = <String>['highest', 'high', 'medium', 'low', 'lowest'];
  final List<String> type = <String>['Practice', 'Chores', 'School', 'Lesson', 'Other'];

  String? DBPriority;
  String? DBType;

  bool showCalendar = false;

  @override
  void initState() {
    super.initState();

  }

  //adds task using info provided in the newTask screen
  addTask() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    //unfocuses everything
    if(!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    Map<String, dynamic> TaskInfo = {
      "taskName": taskNameController.text.trim(),
      "taskDuration": convertTime(hoursController, minutesController),
      "taskDescription": descriptionController.text.trim(),
      "taskDate": dateController.text.trim(),
      "taskDone": false,
      "taskPriority": DBPriority,
      "taskType": DBType
    };

    buildLoading(context);
    //calls addTaskLog to add this task to the taskLog
    addTaskLog(TaskInfo).then((value) {
      //two pops; one for loading, one for leaving newTask screen
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("New Task"),
      ),
      //task name, task date, task time, task type, task difficulty/priority, task description

      body: SingleChildScrollView(
        child: Center(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
        
            children:[
        
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
                  controller: taskNameController,
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
                    onSelected: (String? value) {
                      setState(() {
                        DBType = value!;
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
                    width: 220,
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
                      keyboardType: TextInputType.number,
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
                      keyboardType: TextInputType.number,
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
                    onSelected: (String? value) {
                      setState(() {
                        DBPriority = value!;
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
        
              const SizedBox(
                height: 10,
              ),
        
              ElevatedButton(
                  onPressed: (){
                    //ensure that time is less than 24 hours and that minutes is not funky
                    if (int.parse(minutesController.text) < 60 &&
                        int.parse(hoursController.text) < 24 &&
                        int.parse(minutesController.text) >= 0 &&
                        int.parse(hoursController.text) >= 0) {
                      addTask();
                      sortTaskLog();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const TaskPage()));
                    }
                    else{
                      snackBarBuilder("Invalid duration", context);
                    }
                  },
                  child:
                  const Text('Add Task', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),

              )
        
            ],
          )
        ),
      )
    );
  }
}
