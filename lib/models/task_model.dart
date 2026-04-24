import 'time_range.dart';

class Task {
	const Task({
		required this.id,
		required this.title,
		this.notes,
		this.timeRange,
		required this.isCompleted,
	});

	final String id;
	final String title;
	final String? notes;
	final TimeRange? timeRange;
	final bool isCompleted;

	factory Task.fromJson(Map<String, Object?> json) {
		final timeRangeValue = json['timeRange'];

		return Task(
			id: _requireString(json, 'id'),
			title: _requireString(json, 'title'),
			notes: json['notes'] as String?,
			timeRange: timeRangeValue is Map<Object?, Object?>
					? TimeRange.fromJson(
							Map<String, Object?>.from(timeRangeValue),
						)
					: null,
			isCompleted: _requireBool(json, 'isCompleted'),
		);
	}

	Map<String, Object?> toJson() {
		return <String, Object?>{
			'id': id,
			'title': title,
			'notes': notes,
			'timeRange': timeRange?.toJson(),
			'isCompleted': isCompleted,
		};
	}

	static String _requireString(Map<String, Object?> json, String key) {
		final value = json[key];
		if (value is String) {
			return value;
		}
		throw FormatException('Task.$key is missing or not a String');
	}

	static bool _requireBool(Map<String, Object?> json, String key) {
		final value = json[key];
		if (value is bool) {
			return value;
		}
		throw FormatException('Task.$key is missing or not a bool');
	}
}
