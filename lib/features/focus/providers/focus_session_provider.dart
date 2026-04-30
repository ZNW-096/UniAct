import 'dart:async';

import 'package:flutter/foundation.dart';

import '../../../models/task_model.dart';
import '../../../models/focus_session_model.dart';
import '../../../services/focus_session_service.dart';

class FocusSessionProvider extends ChangeNotifier {
  FocusSessionProvider({required FocusSessionService focusSessionService})
      : _focusSessionService = focusSessionService;

  final FocusSessionService _focusSessionService;

  FocusSession? _currentSession;
  int _totalSeconds = 0;
  int _remainingSeconds = 0;
  bool _isRunning = false;
  bool _isPaused = false;
  bool _isCompleted = false;
  Timer? _timer;
  String? _errorMessage;

  FocusSession? get currentSession => _currentSession;
  int get totalSeconds => _totalSeconds;
  int get remainingSeconds => _remainingSeconds;
  bool get isRunning => _isRunning;
  bool get isPaused => _isPaused;
  bool get isCompleted => _isCompleted;
  String? get errorMessage => _errorMessage;

  void startSession(Task task, int durationMinutes) {
    _timer?.cancel();

    final now = DateTime.now();
    _currentSession = FocusSession(
      id: now.microsecondsSinceEpoch.toString(),
      userId: task.userId,
      taskId: task.id,
      durationMinutes: durationMinutes,
      startTime: now,
      endTime: now.add(Duration(minutes: durationMinutes)),
      isCompleted: false,
    );
    _totalSeconds = durationMinutes * 60;
    _remainingSeconds = _totalSeconds;
    _isRunning = true;
    _isPaused = false;
    _isCompleted = false;

    notifyListeners();
    _saveSessionWithErrorHandling(_currentSession!);

    if (_remainingSeconds == 0) {
      completeSession();
      return;
    }

    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_remainingSeconds <= 1) {
        completeSession();
        return;
      }

      _remainingSeconds -= 1;
      notifyListeners();
    });
  }

  void pauseSession() {
    if (!_isRunning) {
      return;
    }

    _timer?.cancel();
    _isPaused = true;
    _isRunning = false;
    notifyListeners();
  }

  void resumeSession() {
    if (!_isPaused || _currentSession == null) {
      return;
    }

    _isPaused = false;
    _isRunning = true;
    notifyListeners();
    _startTimer();
  }

  void stopSession() {
    _timer?.cancel();
    _currentSession = null;
    _totalSeconds = 0;
    _remainingSeconds = 0;
    _isRunning = false;
    _isPaused = false;
    _isCompleted = false;
    notifyListeners();
  }

  void completeSession() {
    if (_currentSession == null || _isCompleted) {
      return;
    }

    _timer?.cancel();
    final completedSession = FocusSession(
      id: _currentSession!.id,
      userId: _currentSession!.userId,
      taskId: _currentSession!.taskId,
      durationMinutes: _currentSession!.durationMinutes,
      startTime: _currentSession!.startTime,
      endTime: DateTime.now(),
      isCompleted: true,
    );

    _currentSession = completedSession;
    _remainingSeconds = 0;
    _isRunning = false;
    _isPaused = false;
    _isCompleted = true;
    notifyListeners();

    _saveSessionWithErrorHandling(completedSession);
  }

  Future<void> _saveSessionWithErrorHandling(FocusSession session) async {
    try {
      if (session.isCompleted) {
        await _focusSessionService.updateSession(session);
      } else {
        await _focusSessionService.addSession(session);
      }
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to save session: ${e.toString()}';
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
