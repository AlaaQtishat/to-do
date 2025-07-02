import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/screens/tasks_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ChangeNotifierProvider listens to changes in TaskData and notifies its children.
    // It makes TaskData accessible to widgets lower down the widget tree.
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:
            TasksScreen(), // Sets the initial screen of the application to TasksScreen.
      ),
    );
  }
}
