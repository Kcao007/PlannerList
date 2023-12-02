import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Test"),
          actions: <Widget>[
            IconButton(
                icon: const Icon(Icons.add_alert),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('This is an App Bar'))
                  ); // ScaffoldMessenger
                } // onPressed
            )
          ]
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(
                      Icons.favorite,
                      color: Colors.purpleAccent,
                      size: 50.0,
                    ),
                    Icon(
                      Icons.access_time,
                      color: Colors.greenAccent,
                      size: 50.0,
                    ),
                    Icon(
                      Icons.add_box,
                      color: Colors.lightBlueAccent,
                      size: 10.0,
                    ),

                  ] //Children
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                    children:[
                      Image.asset(
                        'assets/puppy.jpeg',
                        height: 70.0,
                      )
                    ]
                ),
              ] //Children
          )
      )
    );
  }
}
