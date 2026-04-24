import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/focus_session_model.dart';

class FocusSessionService {
  FocusSessionService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _sessionsCollection =>
      _firestore.collection('focus_sessions');

  Future<void> addSession(FocusSession session) async {
    await _sessionsCollection.doc(session.id).set(session.toJson());
  }

  Future<List<FocusSession>> getSessionsByTask(String taskId) async {
    final snapshot = await _sessionsCollection
        .where('taskId', isEqualTo: taskId)
        .get();

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
        .snapshots()
        .map(
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
    await _sessionsCollection.doc(session.id).update(session.toJson());
  }
}