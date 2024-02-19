import 'package:flutter/material.dart';
import 'home_page.dart';
import 'tasks.dart';
import 'ranking.dart';
import 'profile.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {

  int _selectedIndex = 0;
  static List<Widget>? _widgetOptions;

  @override
  void initState() {
    super.initState();
    //bar at the bottom with these options
    _widgetOptions = [const HomePage(), const TaskPage(), const RankingPage(), const ProfilePage()];
  }

  //change to whatever tab the user taps on
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child:
            _widgetOptions!.elementAt(_selectedIndex),
      ),

      //just a bunch of icons to help the user know what leads to where
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.data_thresholding),
            label: 'Ranking',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],

        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}
