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
              return Rank(tab: tab.text);
            }).toList(),
          ),
        )

    );
  }
}

class Rank extends StatefulWidget {
  final String? tab;

  Rank({required this.tab});

  @override
  State<Rank> createState() => _RankState();
}

class _RankState extends State<Rank> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Current Tab: " + widget.tab!),


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
    );
  }
}

