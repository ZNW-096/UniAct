import 'package:flutter/foundation.dart';

import '../../../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider({required AuthService authService}) : _authService = authService;

  final AuthService _authService;

  String? _userId;
  bool _isLoading = false;

  String? get userId => _userId;
  bool get isLoading => _isLoading;

  Future<void> signInAnonymously() async {
    _isLoading = true;
    notifyListeners();

    await _authService.signInAnonymously();
    _userId = _authService.currentUser?.uid;

    _isLoading = false;
    notifyListeners();
  }
}
