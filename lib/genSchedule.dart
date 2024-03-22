import 'package:coding_minds_sample/utils.dart';
import 'package:flutter/material.dart';
import 'package:coding_minds_sample/firebase/db.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'dart:convert';

class GenerateSchedulePage extends StatefulWidget {
  final String startDate;
  final String startTime;

  const GenerateSchedulePage(
      {super.key, required this.startDate, required this.startTime});

  @override
  //State<GenerateSchedulePage> createState() => _GenerateSchedulePageState();
  State<StatefulWidget> createState() {
    return _GenerateSchedulePageState();
  }
}

class _GenerateSchedulePageState extends State<GenerateSchedulePage> {

  late final OpenAI _openAI;
  bool isLoading = true;
  List scheduleTasks= [];

  @override
  void initState() {

    _openAI = OpenAI.instance.build(
      token: dotenv.env["OPENAI_KEY"],
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 30),
      )
    );

    handleInitMessage();
    super.initState();
  }

  Future<void> handleInitMessage() async {
    getMyInfo().then((value) async {
      String prompt = 'I need help scheduling my tasks that I need done before the due date. Please create a schedule for my week as a JSON file.'

      'Here are the tasks I want scheduled for me: ${value!["taskLog"]}. The schedule starts on ${widget.startDate} and ends seven days later. The time allotted for scheduling starts at ${widget.startTime} on the first day and ends at 11:59pm on the seventh day.'

      'Create a schedule that contains the date for the task and assigns breaks between tasks based on the tasks’ priority. If the task’s duration is more than 2 hours in length, split the task up across multiple days before the due date. Pay attention to the due date and do not assign tasks to the schedule with a due date that has already passed or a due date that is not within four days after the last day of the schedule.'

      'You must only return a JSON file with your response with no other code or message included. Do not add anything before or after the JSON file.'

      'The JSON file must be in the format of [{‘date’:<date/hour:minute am/pm>, \'task\':{\'task_name\':<task name>, \'due_date\':<date/time>, \'type\':<type>}, \'time_length\':<time_length>}].';
      //dotenv.env["PROMPT"] as String;
      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: prompt,
          )
        ],
        maxToken: 1500,
        model: GptTurbo0631Model(),
      );
      final response = await _openAI.onChatCompletion(request: request);

      setState(() {
        //print(response!.choices.first.message!.content.trim());
        scheduleTasks = jsonDecode(response!.choices.first.message!.content.trim());
        isLoading = false;
      });
    });
  }

  saveSchedule() {
    buildLoading();
    editUserInfo({"schedule": scheduleTasks}).then((value) {
      Navigator.of(context).pop();
      snackBarBuilder("Schedule was saved successfully", context);

    });
  }

  buildLoading() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color> (Colors.blue),
          ));
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Schedule Generator"),
      ),
      
      body: Padding(
          padding: EdgeInsets.all(12),
          child: !isLoading
          ? SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < scheduleTasks.length; i++)
                  Card(
                    child: ListTile(
                      title: Text("Date/time: ${scheduleTasks[i]["date"]}"),
                      subtitle: Text(
                        'Task name: ${scheduleTasks[i]["task"]["task_name"]}\n'
                        'Due date: ${scheduleTasks[i]["task"]["due_date"]}\n'
                        'Type: ${scheduleTasks[i]["task"]["type"]}\n'
                        'Task Length: ${scheduleTasks[i]["time_length"]}\n'
                          ),
                    )
                  ),
              ],
            ),

          )

        : Center(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: const CircularProgressIndicator(),
            )
          )
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: saveSchedule(),
      ),
    );
  }
}
