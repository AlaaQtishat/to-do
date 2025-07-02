class Task {
  final String name; // The name of the task, it's final so we can't change it.
  bool isDone; //A boolean indicating if the task is completed or not.

  Task({required this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  // Converts a Task object into a JSON-compatible Map.
  // This is used when saving tasks to persistent storage (like SharedPreferences).
  Map<String, dynamic> toJson() {
    return {'name': name, 'isDone': isDone};
  }

  // A factory constructor to create a Task object from a JSON-compatible Map.
  // This is used when loading tasks from persistent storage.
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(name: json['name'] as String, isDone: json['isDone'] as bool);
  }
}
