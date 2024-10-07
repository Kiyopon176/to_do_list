import 'package:flutter/material.dart';
import '../models/task.dart';
import '../services/task_service.dart';
import '../widgets/task_list_item.dart';
import '../widgets/task_input.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];
  final TaskService _taskService = TaskService();

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await _taskService.loadTasks();
    setState(() {
      _tasks = tasks;
    });
  }

  void _addTask(String title) {
    setState(() {
      _tasks.add(Task(title: title));
    });
    _taskService.saveTasks(_tasks);
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
    _taskService.saveTasks(_tasks);
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
    _taskService.saveTasks(_tasks);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Column(
        children: [
          TaskInput(onAdd: _addTask),
          Expanded(
            child: _tasks.isEmpty
                ? const Center(
                    child: const Text(
                      'No tasks added yet!',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return TaskListItem(
                        task: _tasks[index],
                        onToggle: () => _toggleTaskCompletion(index),
                        onDelete: () => _removeTask(index),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

