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
  Timer? _timeoutTimer;
  bool _showTimeoutMessage = false;
  AsyncState<List<Task>> _listState = const AsyncState(status: AsyncStatus.idle);
  AsyncState<void> _actionState = const AsyncState(status: AsyncStatus.idle);

  /// State of the task list stream (loading, error, success).
  AsyncStatus get listStatus => _listState.status;
  String? get listErrorMessage => _listState.error;
  
  /// State of the current action (add/update/delete).
  AsyncStatus get actionStatus => _actionState.status;
  String? get actionErrorMessage => _actionState.error;
  
  List<Task> get tasks => _tasks;
  bool get showTimeoutMessage => _showTimeoutMessage;

  void listenToTasks() {
    _tasksSubscription?.cancel();
    // reset state and cancel any existing timeout probe
    _timeoutTimer?.cancel();
    _showTimeoutMessage = false;
    _listState = const AsyncState(status: AsyncStatus.loading);
    notifyListeners();

    // begin listening to the Firestore-backed task stream
    _tasksSubscription = _taskService.watchTasks().listen(
      (List<Task> tasks) {
        // on first successful update cancel probe and clear timeout UI
        _timeoutTimer?.cancel();
        _showTimeoutMessage = false;

        _tasks = tasks;
        _listState = AsyncState(status: AsyncStatus.success, data: tasks);
        notifyListeners();
      },
      onError: (e) {
        // Firestore stream may emit errors (including TimeoutException)
        _listState = AsyncState(status: AsyncStatus.error, error: e.toString());
        notifyListeners();
      },
    );

    // Start a delayed probe: after 10s, if still no success and no local tasks,
    // query the server once to see if tasks actually exist there. If they do,
    // surface the timeout message in the UI.
    _timeoutTimer = Timer(const Duration(seconds: 10), () async {
      if (_listState.status != AsyncStatus.success && _tasks.isEmpty) {
        try {
          final remote = await _taskService.getTasks();
          if (remote.isNotEmpty) {
            _showTimeoutMessage = true;
            notifyListeners();
          }
        } catch (_) {
          // ignore probe failures
        }
      }
    });
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
    _timeoutTimer?.cancel();
    _tasksSubscription?.cancel();
    super.dispose();
  }
}
