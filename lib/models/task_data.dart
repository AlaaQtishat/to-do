import 'package:flutter/foundation.dart';
import 'package:todoey/models/task.dart';
import 'dart:collection';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// TaskData is a ChangeNotifier, meaning it can notify its listeners (widgets)
// when its internal data (_tasks) changes, triggering a UI rebuild.
class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];
  // A constant string key used to save and retrieve the task list from SharedPreferences.
  static const String _tasksKey = 'tasks_list';

  // Constructor for TaskData.
  // When an instance of TaskData is created, it immediately tries to load saved tasks.

  TaskData() {
    _loadTasks();
  }

  // Asynchronous method to load tasks from SharedPreferences.
  Future<void> _loadTasks() async {
    // Get an instance of SharedPreferences. 'await' is used because this is an asynchronous operation.
    final prefs = await SharedPreferences.getInstance();
    // Retrieve the stored tasks as a JSON string using the predefined key.
    final String? tasksString = prefs.getString(_tasksKey);

    // Check if any tasks were found in storage.
    if (tasksString != null) {
      // Decode the JSON string back into a List of dynamic maps.
      final List<dynamic> taskMaps = jsonDecode(tasksString);
      // Map each dynamic map back to a Task object using the Task.fromJson factory constructor.
      _tasks = taskMaps.map((map) => Task.fromJson(map)).toList();
      // Notify all listening widgets that the task list has been updated,
      // so they can rebuild with the loaded data.
      notifyListeners();
    }
  }

  // Asynchronous method to save the current tasks list to SharedPreferences.
  Future<void> _saveTasks() async {
    // Get an instance of SharedPreferences.
    final prefs = await SharedPreferences.getInstance();
    // Convert the list of Task objects into a list of JSON-compatible maps.
    final List<Map<String, dynamic>> taskMaps = _tasks
        .map((task) => task.toJson())
        .toList();
    // Encode the list of maps into a single JSON string.
    final String tasksString = jsonEncode(taskMaps);
    // Save the JSON string to SharedPreferences using the predefined key.
    await prefs.setString(_tasksKey, tasksString);
  }

  //using the UnmodifiableListView to prevent external widgets from directly modifying the internal _tasks list,
  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  // Method to add a new task to the list.
  void addTask(String newTaskTitle) {
    if (newTaskTitle.trim().isEmpty) {
      return; //
    }

    // Create a new Task object with the provided title.
    final task = Task(name: newTaskTitle);
    // Add the new task to the internal list.
    _tasks.add(task);
    // Notify listeners that the data has changed.
    notifyListeners();
    // Save the updated list to persistent storage.
    _saveTasks();
  }

  // Method to update a task's completion status.
  void updateTask(Task task) {
    // Call the toggleDone method on the specific task to change its status.
    task.toggleDone();
    // Notify listeners that the data has changed.
    notifyListeners();
    // Save the updated list to persistent storage.
    _saveTasks();
  }

  // Method to delete a task from the list.
  void deleteTask(Task task) {
    // Remove the specified task from the internal list.
    _tasks.remove(task);
    // Notify listeners that the data has changed.
    notifyListeners();
    // Save the updated list to persistent storage.
    _saveTasks();
  }
}
