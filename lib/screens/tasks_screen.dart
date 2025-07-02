import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoey/widgets/tasks_list.dart';
import 'package:todoey/screens/add_task_screen.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            //(a screen that slides up from the bottom).
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                // Adds padding at the bottom equal to the keyboard's height to prevent the input field from being obscured by the keyboard.
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child:
                    AddTaskScreen(), // Displays the AddTaskScreen inside the bottom sheet.
              ),
            ),
          );
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: 60.0,
              left: 30.0,
              right: 30.0,
              bottom: 30.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  child: Icon(
                    Icons.checklist,
                    size: 30.0,
                    color: Colors.pinkAccent,
                  ),
                  backgroundColor: Colors.white,
                  radius: 30.0,
                ),
                SizedBox(height: 10.0),
                Text(
                  'TO-DO list',
                  style: GoogleFonts.pacifico(
                    color: Colors.white,
                    fontSize: 50.0,
                    fontWeight: FontWeight.w700,
                  ),
                  // style: TextStyle(
                  //   color: Colors.white,
                  //   fontSize: 50.0,
                  //   fontWeight: FontWeight.w700,
                  // ),
                ),
                Text(
                  // Accesses TaskData using Provider.of without 'listen: false' because this Text widget needs to rebuild whenever taskCount changes.
                  '${Provider.of<TaskData>(context).taskCount} Tasks',
                  style: GoogleFonts.acme(color: Colors.white, fontSize: 19),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: TasksList(),
            ),
          ),
        ],
      ),
    );
  }
}
