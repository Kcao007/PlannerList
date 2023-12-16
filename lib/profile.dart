import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = TextEditingController();
  final hobbyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Profile"),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                    labelText: 'age',
                  ),
                  controller: ageController,
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
                    labelText: 'gender',
                  ),
                  controller: genderController,
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
                    labelText: 'hobbies',
                  ),
                  controller: hobbyController,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

            ],
          )
        )
    );
  }
}
