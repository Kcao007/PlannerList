import 'package:flutter/material.dart';
import 'package:coding_minds_sample/firebase/db.dart';
import 'package:coding_minds_sample/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final usernameController = TextEditingController();
  final ageController = TextEditingController();
  final bioController = TextEditingController();

  final List<String> gender = <String>['Prefer not to answer', 'Male', 'Female', 'Other', ];

  String? DBgender;
  bool hasGender = false;

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  //calls getMyInfo and stores values to be displayed on profile screen in textEditingControllers
  getInfo() async {
    getMyInfo().then((info) {
      if (info != null) {
        hasGender = true;
        setState(() {
          usernameController.text = info["nickname"];
          ageController.text = info["age"];
          bioController.text = info["bio"];
          DBgender = info["gender"];
        });
      }
    });
  }

  //to change the user's info in the database by changing profile screen values
  updateInfo() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if(!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }

    Map<String, dynamic> userInfo = {
      "nickname": usernameController.text.trim(),
      "age": ageController.text.trim(),
      "bio": bioController.text.trim(),
      "gender": DBgender,
    };

    buildLoading(context);
    editUserInfo(userInfo).then((value) {
      Navigator.of(context).pop();
      //called from util to create a notification
      snackBarBuilder("User info updated", context);
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("Profile"),
        ),

        body: SingleChildScrollView(
          child: Center(
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

                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('Gender', style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),

                      const SizedBox(
                        width: 10,
                      ),

                      DropdownMenu<String>(
                        width: 255,
                        initialSelection: hasGender? DBgender: gender.first,
                        requestFocusOnTap: false,
                        onSelected: (String? value) {
                          FocusScope.of(context).unfocus();
                          setState(() {
                            DBgender = value!;
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
                    keyboardType: TextInputType.number,
                    maxLength: 3,
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
                  onPressed: (){
                    updateInfo();
                  },
                  child:
                    const Text('Save', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                )

              ],
            )
          ),
        )
    );
  }
}
