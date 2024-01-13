import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final bioController = TextEditingController();

  final List<String> gender = <String>[' ', 'Male', 'Female', 'Other', 'Prefer not to answer'];

  @override
  Widget build(BuildContext context) {

    String dropDownValue = gender.first;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Icon(Icons.man),
        ),

        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              const SizedBox(
                height : 10,
              ),

              const Text('Profile', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),

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
                    labelText: 'Username',
                  ),
                  controller: usernameController,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              SizedBox(
                width: 350,
                child: TextField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Age',
                  ),
                  controller: ageController,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Gender', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

                  const SizedBox(
                    width: 10,
                  ),

                  DropdownMenu<String>(
                    width: 255,
                    initialSelection: gender.first,
                    onSelected: (String? value) {
                      setState(() {
                        dropDownValue = value!;
                      });
                    },
                    dropdownMenuEntries: gender.map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry<String>(value: value, label: value);
                    }).toList(),
                  ),

                ]
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
                    labelText: 'Bio',
                  ),
                  controller: bioController,
                ),
              ),

              const SizedBox(
                height: 10,
              ),
              
              ElevatedButton(
                onPressed: (){},
                child:
                  const Text('Save', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
              )

            ],
          )
        )
    );
  }
}
