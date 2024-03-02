import 'package:coding_minds_sample/firebase/db.dart';
import 'package:flutter/material.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {

  final List<Tab> tabs = <Tab>[
    const Tab(text: 'Day',),
    const Tab(text: 'Week',),
    const Tab(text: 'Month',),
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
            title: const Text('Ranking'),
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

  Map<String, dynamic> rank = {};

  @override
  void initState() {

    super.initState();
    getRank();
  }

  Future<void> getRank() async {
    getUserRankDate(widget.tab!).then((value) {
      List<MapEntry<String, dynamic>> rankList = value.entries.toList();
      rankList.sort((a, b) => b.value.compareTo(a.value));

      setState(() {
        rank = Map.fromEntries(rankList);
        print(rank);
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListView.builder(
            shrinkWrap: true,
            //make it scrollable
            physics: const ClampingScrollPhysics(),
            //make it so you cant scroll off the screen
            itemCount: rank.length,
            itemBuilder: (context, index) {
              String username = rank.keys.elementAt(index);
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child:
                  Text("${index + 1}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                ),
                title: Text("     ${username}", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                trailing: Text("${rank[username]}" + "%",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),

              );
            }
        )
      ],
    );
  }
}