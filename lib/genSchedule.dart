import 'package:coding_minds_sample/navigation.dart';
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
      //the prompt (had to threaten the AI a bit)
      print(value!["tasklog"]);

      String prompt =  'I need help scheduling my tasks that I need done before the due date. Please create a schedule for my week as a JSON data.'

          'Here are the tasks I want scheduled for me: ${value!["taskLog"]}. The schedule starts on ${widget.startDate} and ends seven days later. The time allotted for scheduling starts at ${widget.startTime} on the first day and only the first day and ends at 11:59pm on the seventh day. Ignore tasks with the taskDone key set to true.'

          'Create a schedule that contains the date for the task and assigns breaks between tasks based on the tasks’ priority. EXTREMELY IMPORTANT. Only schedule each task once. Pay attention to the due date and do not assign tasks to the schedule with a due date that has already passed or a due date that is not within four days after the last day of the schedule. The duration of each task per name should add up to TaskDuration.'

          'EXTREMELY IMPORTANT. Do not schedule tasks during the normal sleeping hours of 10:00pm and 8:00am. Once the task is accounted for, no more occurrences of this task may be made. Once the task\'s due date has passed or the task duration is covered, do not schedule it again. Your response cannot exceed 3000 characters in length. After you assign a task, do not schedule another task for another (Task Length) hours. Do not schedule breaks as tasks; simply leave the time slot empty and start the next task after the break.'

          'You must only return a JSON data with your response with no other code or message included. Start the beginning of your response with your JSON data. Do not add anything before or after the JSON data. Also ensure that you do not end your response without properly ending the JSON data. If you add any other characters beside the JSON data a human will die.'

          'The JSON data must be in the format of [{‘date’:<date/hour:minute am/pm>, \'task\':{\'task_name\':<task name>, \'due_date\':<date/time>, \'type\':<type>}, \'time_length\':<time_length>}].';

      final request = ChatCompleteText(
        messages: [
          Messages(
            role: Role.user,
            content: prompt,
          )
        ],
        maxToken: 3000,
        model: GptTurbo0631Model(),
      );
      final response = await _openAI.onChatCompletion(request: request);

      //takes the AI output thats formatted like a JSON file and reads it as one to get the schedule
      setState(() {
        print(response!.choices.first.message!.content.trim());
        scheduleTasks = jsonDecode(response!.choices.first.message!.content.trim());
        //removes loading wheel
        isLoading = false;
      });
    });
  }

  //saves the schedule as a key in the user data
  saveSchedule() {
    buildLoading();
    editUserInfo({"schedule": scheduleTasks}).then((value) {
      Navigator.of(context).pop();
      snackBarBuilder("Schedule was saved successfully", context);

    });
  }

  //loading wheel for during schedule generation
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

      //preview of schedule to be saved
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
                        'Task Length: ${scheduleTasks[i]["time_length"]}\n hours'
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

      //calls saveSchedule to save data into the key
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        onPressed: //() {
          saveSchedule,
          //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationPage()));
        //}
      ),
    );
  }
}
