import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../models/task_model.dart';
import '../../../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider({required TaskService taskService}) : _taskService = taskService;

  final TaskService _taskService;

  List<Task> _tasks = <Task>[];
  bool _isLoading = false;
  StreamSubscription<List<Task>>? _tasksSubscription;

  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;

  void listenToTasks() {
    _tasksSubscription?.cancel();
    _isLoading = true;
    notifyListeners();

    _tasksSubscription = _taskService.watchTasks().listen((List<Task> tasks) {
      _tasks = tasks;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addTask(Task task) async {
    await _taskService.addTask(task);
  }

  Future<void> updateTask(Task task) async {
    await _taskService.updateTask(task);
  }

  Future<void> deleteTask(String id) async {
    await _taskService.deleteTask(id);
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }
}
