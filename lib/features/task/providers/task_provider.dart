import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../core/state/async_state.dart';
import '../../../models/task_model.dart';
import '../../../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider({required TaskService taskService}) : _taskService = taskService;

  final TaskService _taskService;

  List<Task> _tasks = <Task>[];
  StreamSubscription<List<Task>>? _tasksSubscription;
  AsyncState<List<Task>> _listState = const AsyncState(status: AsyncStatus.idle);
  AsyncState<void> _actionState = const AsyncState(status: AsyncStatus.idle);

  /// State of the task list stream (loading, error, success).
  AsyncStatus get listStatus => _listState.status;
  String? get listErrorMessage => _listState.error;
  
  /// State of the current action (add/update/delete).
  AsyncStatus get actionStatus => _actionState.status;
  String? get actionErrorMessage => _actionState.error;
  
  List<Task> get tasks => _tasks;

  void listenToTasks() {
    _tasksSubscription?.cancel();
    _listState = const AsyncState(status: AsyncStatus.loading);
    notifyListeners();

    _tasksSubscription = _taskService.watchTasks().listen(
      (List<Task> tasks) {
        _tasks = tasks;
        _listState = AsyncState(status: AsyncStatus.success, data: tasks);
        notifyListeners();
      },
      onError: (e) {
        _listState = AsyncState(status: AsyncStatus.error, error: e.toString());
        notifyListeners();
      },
    );
  }

  Future<void> addTask(Task task) async {
    _actionState = const AsyncState(status: AsyncStatus.loading);
    notifyListeners();
    try {
      await _taskService.addTask(task);
      _actionState = const AsyncState(status: AsyncStatus.success);
    } catch (e) {
      _actionState = AsyncState(status: AsyncStatus.error, error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> updateTask(Task task) async {
    _actionState = const AsyncState(status: AsyncStatus.loading);
    notifyListeners();
    try {
      await _taskService.updateTask(task);
      _actionState = const AsyncState(status: AsyncStatus.success);
    } catch (e) {
      _actionState = AsyncState(status: AsyncStatus.error, error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<void> deleteTask(String id) async {
    _actionState = const AsyncState(status: AsyncStatus.loading);
    notifyListeners();
    try {
      await _taskService.deleteTask(id);
      _actionState = const AsyncState(status: AsyncStatus.success);
    } catch (e) {
      _actionState = AsyncState(status: AsyncStatus.error, error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _tasksSubscription?.cancel();
    super.dispose();
  }
}
