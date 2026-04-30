import 'auth_service.dart';
import 'focus_session_service.dart';
import 'task_service.dart';

class AccountErasureService {
  AccountErasureService({
    required TaskService taskService,
    required FocusSessionService focusSessionService,
    required AuthService authService,
  })  : _taskService = taskService,
        _focusSessionService = focusSessionService,
        _authService = authService;

  final TaskService _taskService;
  final FocusSessionService _focusSessionService;
  final AuthService _authService;

  Future<void> eraseCurrentUserData() async {
    await _taskService.deleteAllForCurrentUser();
    await _focusSessionService.deleteAllForCurrentUser();
    await _authService.deleteCurrentUser();
    await _authService.signOut();
  }
}
