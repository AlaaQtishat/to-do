import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoey/models/task.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String newTaskTitle =
        ''; // Declares a variable to hold the new task's title entered by the user.

    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Add a task',
              textAlign: TextAlign.center,
              style: GoogleFonts.acme(fontSize: 30.0, color: Colors.pinkAccent),
            ),

            TextField(
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.pinkAccent,
                    width: 2,
                  ), // Make it slightly thicker when focused
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              autofocus: true,

              textAlign: TextAlign.center,
              // Callback that updates newTaskTitle whenever the text field's value changes.
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            SizedBox(height: 20),
            TextButton(
              child: Text('Add', style: GoogleFonts.acme(color: Colors.white)),
              style: TextButton.styleFrom(backgroundColor: Colors.pinkAccent),
              onPressed: () {
                // Accesses TaskData using Provider.of.
                // 'listen: false' is crucial here because we only want to call a method (addTask) and not rebuild this widget when TaskData changes
                Provider.of<TaskData>(
                  context,
                  listen: false,
                ).addTask(newTaskTitle);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
