import 'package:flutter/material.dart';
import 'package:todoey/widgets/task_tile.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task_data.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Consumer widget listens for changes in TaskData.
    // When TaskData notifies its listeners (e.g., a task is added/deleted/updated),
    // the builder function will be re-executed to rebuild the UI.
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              // Callback for when the checkbox in TaskTile is tapped.
              // It calls the updateTask method in TaskData to toggle the task's status.
              checkboxCallback: (checkboxState) {
                taskData.updateTask(task);
              },
              // Callback for when the delete icon in TaskTile is pressed.
              // It calls the deleteTask method in TaskData to remove the task.
              deleteIconCallback: () {
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
