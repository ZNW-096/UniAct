class TimeRange {
  const TimeRange({
    this.start,
    this.end,
  });

  final DateTime? start;
  final DateTime? end;

  factory TimeRange.fromJson(Map<String, Object?> json) {
    return TimeRange(
      start: _parseDateTime(json['start']),
      end: _parseDateTime(json['end']),
    );
  }

  Map<String, Object?> toJson() {
    return <String, Object?>{
      'start': start?.toIso8601String(),
      'end': end?.toIso8601String(),
    };
  }

  static DateTime? _parseDateTime(Object? value) {
    if (value == null) {
      return null;
    }

    if (value is String && value.isNotEmpty) {
      return DateTime.parse(value);
    }

    return null;
  }
}