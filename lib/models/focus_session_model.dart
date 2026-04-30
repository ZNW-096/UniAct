class FocusSession {
  const FocusSession({
    required this.id,
    required this.userId,
    required this.taskId,
    required this.durationMinutes,
    required this.startTime,
    required this.endTime,
    required this.isCompleted,
  });

  final String id;
  final String userId;
  final String taskId;
  final int durationMinutes;
  final DateTime startTime;
  final DateTime endTime;
  final bool isCompleted;

  factory FocusSession.fromJson(Map<String, Object?> json) {
    return FocusSession(
      id: _requireString(json, 'id'),
      userId: _requireString(json, 'userId'),
      taskId: _requireString(json, 'taskId'),
      durationMinutes: _requireInt(json, 'durationMinutes'),
      startTime: _requireDateTime(json, 'startTime'),
      endTime: _requireDateTime(json, 'endTime'),
      isCompleted: _requireBool(json, 'isCompleted'),
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'id': id,
      'userId': userId,
      'taskId': taskId,
      'durationMinutes': durationMinutes,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }

  static String _requireString(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is String) {
      return value;
    }
    throw FormatException('FocusSession.$key is missing or not a String');
  }

  static int _requireInt(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is int) {
      return value;
    }
    throw FormatException('FocusSession.$key is missing or not an int');
  }

  static bool _requireBool(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is bool) {
      return value;
    }
    throw FormatException('FocusSession.$key is missing or not a bool');
  }

  static DateTime _requireDateTime(Map<String, Object?> json, String key) {
    final value = json[key];
    if (value is String && value.isNotEmpty) {
      return DateTime.parse(value);
    }
    throw FormatException(
      'FocusSession.$key is missing or not a valid ISO8601 string',
    );
  }
}