import 'package:coding_minds_sample/firebase/db.dart';
import 'package:coding_minds_sample/utils.dart';
import 'package:flutter/material.dart';
import 'package:coding_minds_sample/newTask.dart';


class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  final List<Tab> tabs = <Tab>[
    const Tab(text: 'Day',),
    const Tab(text: 'Week',),
    const Tab(text: 'All',),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            toolbarHeight: 40,
            title: const Text('Tasks'),
            bottom: TabBar(
              tabs: tabs,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
            ),
          ),
          body: TabBarView(
            children: tabs.map((Tab tab) {
              return Task(tab: tab.text);
            }).toList(),
          ),

          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,

            //add task button, navigates to newTask.dart
            children: <Widget>[
              FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const NewTaskPage()));
                },
                label: const Text('Add Task', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                icon: const Icon(Icons.add_box),
              ),

              const SizedBox(
                height: 20,
              ),
            ]
          )
        )

    );
  }
}

class Task extends StatefulWidget {
  final String? tab;

  Task({required this.tab});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {

  List <TaskItem> tasks = [];
  List taskLog = [];

  @override
  void initState() {
    super.initState();
    setTask();
    sortTaskLog();
  }

  //adds tasks to screen
  void setTask() {
    //gets tasks within the date range and adds them to tasks
    getTasksByDateRange(widget.tab!).then((value) {
      setState(() {
        for(var element in value) {
          tasks.add(TaskItem(
            name: element["taskName"],
            date: element["taskDate"],
            time: element["taskDuration"],
            priority: element["taskPriority"],
            type: element["taskType"],
            completed: element["taskDone"],
            id: element["index"],
          ));
        }
      });
    });


  }

  //
  Future<List<Map<String, dynamic>>> getTasksByDateRange(String range) async {
    List<Map<String, dynamic>> tasks = [];
    taskLog = await getMyTaskLog();

    //All tab should have all tasks in list
    if(widget.tab! == "All") {

      for (int i = 0; i < taskLog.length; i++) {
        Map<String, dynamic> element = taskLog[i];
        element["index"] = i;
        tasks.add(element);
      }
    }

    //otherwise it should only have the ones in the date range
    else {
      //calls startEndDate from utils.dart
      Map value = startEndDate(range);
      DateTime startDate = value["startDate"];
      DateTime endDate = value["endDate"];

      //goes through all tasks in taskLog
      for(int i = 0; i < taskLog.length; i++) {
        Map<String, dynamic> element = taskLog[i];
        DateTime elementDate = DateTime.parse(element["taskDate"]);

        //checks if the task's date is within the bounds of the tab
        if(elementDate.isAfter(startDate) && elementDate.isBefore(endDate) || elementDate == startDate) {
          element["index"] = i;
          tasks.add(element);
        }
      }
    }

  return tasks;
  }

  //actually displaying the tasks on the screen
  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('No More Tasks!!!', style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
              ],
            ),
          )
        : ListView(
            children: [
              ListView.builder(
                shrinkWrap: true, //make it scrollable
                physics: const ClampingScrollPhysics(), //make it so you cant scroll off the screen
                itemCount: tasks.length,
                itemBuilder: (context, index) {

                  //how it displays each individual task
                  return ListTile(
                    title: Text(tasks[index].name),
                    subtitle: Text('Date/Priority: ${tasks[index].date}, ${tasks[index].priority}'),

                    trailing: Checkbox(
                      onChanged: (bool? value) {
                        setState(() {
                          tasks[index].completed = value ?? false;
                        });

                        //enables changing the taskDone value from false to true and vice versa
                        taskLog[tasks[index].id] ["taskDone"] = tasks[index].completed;
                        updateTaskLog(taskLog);
                      },
                      value: tasks[index].completed
                    ),

                    //opens another page, TaskInfo.dart, which gives all details of a task
                    onTap: () {

                    },
                  );
                }, //itemBuilder
              ),

              const SizedBox(
              height: 40
              ),
            ], //ListView children
          );
  }
}

//for creating a new Task and verifying that all parts are there
class TaskItem {
  String name;
  String date;
  String time;
  String priority;
  String type;
  bool completed;
  int id;

  TaskItem({
    required this.name,
    required this.date,
    required this.time,
    required this.priority,
    required this.type,
    this.completed = false,
    required this.id,
  });

}
