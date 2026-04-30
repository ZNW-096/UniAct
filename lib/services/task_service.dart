import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'auth_service.dart';
import '../models/task_model.dart';

class TaskService {
	TaskService({FirebaseFirestore? firestore, AuthService? authService})
			: _firestore = firestore ?? FirebaseFirestore.instance,
			  _authService = authService ?? AuthService();

	// Duration used to timeout network operations to avoid UI hangs
	static const Duration _networkTimeout = Duration(seconds: 10);

	final FirebaseFirestore _firestore;
	final AuthService _authService;

	CollectionReference<Map<String, dynamic>> get _tasksCollection =>
			_firestore.collection('tasks');

	String get _currentUserId {
		final userId = _authService.currentUser?.uid;
		if (userId == null) {
			throw StateError('User must be signed in to access tasks');
		}
		return userId;
	}

	Future<List<Task>> getTasks() async {
		final snapshot = await _tasksCollection
			.where('userId', isEqualTo: _currentUserId)
			.get()
			.timeout(_networkTimeout);
		return snapshot.docs
				.map(
					(doc) => Task.fromJson(
						<String, Object?>{
							...doc.data(),
							'id': doc.id,
						},
					),
				)
				.toList();
	}

	Stream<List<Task>> watchTasks() {
		return _tasksCollection
			.where('userId', isEqualTo: _currentUserId)
			.snapshots()
			.timeout(_networkTimeout, onTimeout: (sink) {
				// Emit a timeout error downstream so UI can react.
				sink.addError(TimeoutException('No task updates received within ${_networkTimeout.inSeconds}s'));
			})
			.map(
				(snapshot) => snapshot.docs
					.map(
						(doc) => Task.fromJson(
							<String, Object?>{
								...doc.data(),
								'id': doc.id,
							},
						),
					)
					.toList(),
				);
	}

	Future<void> addTask(Task task) async {
		await _tasksCollection
			.doc(task.id)
			.set(
				<String, Object?>{
					...task.toJson(),
					'userId': _currentUserId,
				},
			)
			.timeout(_networkTimeout);
	}

	Future<void> updateTask(Task task) async {
		await _tasksCollection
			.doc(task.id)
			.update(
				<String, Object?>{
					...task.toJson(),
					'userId': _currentUserId,
				},
			)
			.timeout(_networkTimeout);
	}

	Future<void> deleteTask(String id) async {
		await _tasksCollection.doc(id).delete().timeout(_networkTimeout);
	}

	Future<void> deleteAllForCurrentUser() async {
		final snapshot = await _tasksCollection
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
