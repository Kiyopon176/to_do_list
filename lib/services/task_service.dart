import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';
import 'dart:convert';

class TaskService {
  static const String _taskKey = 'tasks';

  Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? tasksJson = prefs.getString(_taskKey);
    if (tasksJson == null) return [];

    final List<dynamic> tasksList = json.decode(tasksJson);
    return tasksList.map((task) => Task.fromMap(task)).toList();
  }

  Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final String tasksJson = json.encode(tasks.map((task) => task.toMap()).toList());
    await prefs.setString(_taskKey, tasksJson);
  }
}
