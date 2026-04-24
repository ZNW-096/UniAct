import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task_model.dart';

class TaskService {
	TaskService({FirebaseFirestore? firestore})
			: _firestore = firestore ?? FirebaseFirestore.instance;

	final FirebaseFirestore _firestore;

	CollectionReference<Map<String, dynamic>> get _tasksCollection =>
			_firestore.collection('tasks');

	Future<List<Task>> getTasks() async {
		final snapshot = await _tasksCollection.get();
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
		return _tasksCollection.snapshots().map(
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
		await _tasksCollection.doc(task.id).set(task.toJson());
	}

	Future<void> updateTask(Task task) async {
		await _tasksCollection.doc(task.id).update(task.toJson());
	}

	Future<void> deleteTask(String id) async {
		await _tasksCollection.doc(id).delete();
	}
}
