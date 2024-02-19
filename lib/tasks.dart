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
  }

  void setTask() {
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

  Future<List<Map<String, dynamic>>> getTasksByDateRange(String range) async {
    List<Map<String, dynamic>> tasks = [];
    if(widget.tab! == "All") {
      taskLog = await getMyTaskLog();

      for (int i = 0; i < taskLog.length; i++) {
        Map<String, dynamic> element = taskLog[i];
        element["index"] = i;
        tasks.add(element);
      }
    }

    else {
      Map value = startEndDate(range);
      DateTime startDate = value["startDate"];
      DateTime endDate = value["endDate"];
      taskLog = await getMyTaskLog();

      for(int i = 0; i < taskLog.length; i++) {
        Map<String, dynamic> element = taskLog[i];
        DateTime elementDate = DateTime.parse(element["taskDate"]);
        if(elementDate.isAfter(startDate) && elementDate.isBefore(endDate) || elementDate == startDate) {
          element["index"] = i;
          tasks.add(element);
        }
      }
    }

  return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("No Tasks") // fix font stuff later
              ],
            ),
          )
        : ListView(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: tasks.length,
                itemBuilder: (context, index) {

                  return ListTile(
                    title: Text(tasks[index].name),
                    subtitle: Text('Date/Time: ${tasks[index].date}, ${tasks[index].time}Hrs'),

                    trailing: Checkbox(
                      onChanged: (bool? value) {
                        setState(() {
                          tasks[index].completed = value ?? false;
                        });
                        taskLog[tasks[index].id] ["taskDone"] = tasks[index].completed;
                        updateTaskLog(taskLog);
                      },
                      value: tasks[index].completed
                    ),
                    onTap: ,
                  );
                }, //itemBuilder
              ),

              const SizedBox(
              height: 60
              ),
            ], //ListView children
          );

  }
}

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