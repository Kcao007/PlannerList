import 'package:flutter/material.dart';

class RankPage extends StatefulWidget {
  const RankPage({super.key});

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {

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
          backgroundColor: Color(0xFF68A268),
          toolbarHeight: 80,
          title: const Text(
            'Rank Screen'
          ),
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
      body: Text("Current Tab: " + widget.tab!)
    );
  }
}

