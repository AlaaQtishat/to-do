import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  // Callback function executed when the checkbox's state changes.
  final Function(bool?)? checkboxCallback;
  // Callback function executed when the delete icon button is pressed.
  final VoidCallback? deleteIconCallback;

  const TaskTile({
    required this.isChecked,
    required this.taskTitle,
    this.checkboxCallback,
    this.deleteIconCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min, // Keep the row compact
        children: [
          Checkbox(
            activeColor: Colors.pinkAccent,
            value: isChecked,
            onChanged: checkboxCallback,
          ),
          if (deleteIconCallback !=
              null) // Only show the button if callback is provided
            IconButton(
              icon: Icon(Icons.delete_forever),
              color: Colors.black,
              onPressed: deleteIconCallback,
            ),
        ],
      ),
    );
  }
}
