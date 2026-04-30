import 'package:flutter/foundation.dart';

import '../../../core/state/async_state.dart';
import '../../../services/account_erasure_service.dart';
import '../../../services/auth_service.dart';
import '../../../services/focus_session_service.dart';
import '../../../services/task_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({
    required AuthService authService,
    AccountErasureService? accountErasureService,
  })  : _authService = authService,
        _accountErasureService =
            accountErasureService ??
            AccountErasureService(
              taskService: TaskService(authService: authService),
              focusSessionService: FocusSessionService(authService: authService),
              authService: authService,
            );

  final AuthService _authService;
  final AccountErasureService _accountErasureService;

  AsyncState<String?> _state = const AsyncState(status: AsyncStatus.idle, data: null);

  AsyncStatus get status => _state.status;
  String? get userId => _state.data;
  String? get errorMessage => _state.error;

  Future<void> signInAnonymously() async {
    _state = const AsyncState(status: AsyncStatus.loading);
    notifyListeners();

    try {
      await _authService.signInAnonymously();
      final uid = _authService.currentUser?.uid;
      _state = AsyncState(status: AsyncStatus.success, data: uid);
    } catch (e) {
      _state = AsyncState(status: AsyncStatus.error, error: e.toString());
    } finally {
      notifyListeners();
    }
  }

  Future<bool> deleteMyDataAndAccount() async {
    _state = const AsyncState(status: AsyncStatus.loading);
    notifyListeners();

    try {
      await _accountErasureService.eraseCurrentUserData();
      await _authService.signInAnonymously();
      _state = AsyncState(
        status: AsyncStatus.success,
        data: _authService.currentUser?.uid,
      );
      return true;
    } catch (e) {
      _state = AsyncState(status: AsyncStatus.error, error: e.toString());
      return false;
    } finally {
      notifyListeners();
    }
  }
}
