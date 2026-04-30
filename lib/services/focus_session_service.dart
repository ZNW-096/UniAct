import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_service.dart';
import '../models/focus_session_model.dart';

class FocusSessionService {
  FocusSessionService({FirebaseFirestore? firestore, AuthService? authService})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _authService = authService ?? AuthService();

  final FirebaseFirestore _firestore;
  final AuthService _authService;

  static const Duration _networkTimeout = Duration(seconds: 10);

  CollectionReference<Map<String, dynamic>> get _sessionsCollection =>
      _firestore.collection('focus_sessions');

  String get _currentUserId {
    final userId = _authService.currentUser?.uid;
    if (userId == null) {
      throw StateError('User must be signed in to access focus sessions');
    }
    return userId;
  }

  Future<void> addSession(FocusSession session) async {
    await _sessionsCollection
        .doc(session.id)
        .set(
          <String, Object?>{
            ...session.toJson(),
            'userId': _currentUserId,
          },
        )
        .timeout(_networkTimeout);
  }

  Future<List<FocusSession>> getSessionsByTask(String taskId) async {
    final snapshot = await _sessionsCollection
        .where('taskId', isEqualTo: taskId)
        .where('userId', isEqualTo: _currentUserId)
        .get()
        .timeout(_networkTimeout);

    return snapshot.docs
        .map(
          (doc) => FocusSession.fromJson(
            <String, Object?>{
              ...doc.data(),
              'id': doc.id,
            },
          ),
        )
        .toList();
  }

  Stream<List<FocusSession>> watchSessionsByTask(String taskId) {
    return _sessionsCollection
        .where('taskId', isEqualTo: taskId)
        .where('userId', isEqualTo: _currentUserId)
        .snapshots()
        .timeout(_networkTimeout, onTimeout: (sink) {
          sink.addError(TimeoutException('No focus session updates received within ${_networkTimeout.inSeconds}s'));
        }).map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => FocusSession.fromJson(
                  <String, Object?>{
                    ...doc.data(),
                    'id': doc.id,
                  },
                ),
              )
              .toList(),
        );
  }

  Future<void> updateSession(FocusSession session) async {
    await _sessionsCollection
        .doc(session.id)
        .update(
          <String, Object?>{
            ...session.toJson(),
            'userId': _currentUserId,
          },
        )
        .timeout(_networkTimeout);
  }

  Future<void> deleteAllForCurrentUser() async {
    final snapshot = await _sessionsCollection
        .where('userId', isEqualTo: _currentUserId)
        .get()
        .timeout(_networkTimeout);

    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit().timeout(_networkTimeout);
  }
}