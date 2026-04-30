import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  AuthService({FirebaseAuth? auth}) : _auth = auth ?? FirebaseAuth.instance;

  final FirebaseAuth _auth;
  static const Duration _authTimeout = Duration(seconds: 10);

  User? get currentUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<void> signInAnonymously() async {
    if (_auth.currentUser != null) {
      return;
    }
    try {
      await _auth.signInAnonymously().timeout(_authTimeout);
    } on TimeoutException {
      throw TimeoutException('Anonymous sign-in timed out (${_authTimeout.inSeconds}s)');
    }
  }

  Future<void> deleteCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) {
      return;
    }
    await user.delete().timeout(_authTimeout);
  }

  Future<void> signOut() async {
    await _auth.signOut().timeout(_authTimeout);
  }
}