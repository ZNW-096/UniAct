enum AsyncStatus { idle, loading, success, error }

class AsyncState<T> {
  const AsyncState({required this.status, this.data, this.error});

  final AsyncStatus status;
  final T? data;
  final String? error;

  AsyncState<T> copyWith({AsyncStatus? status, T? data, String? error}) {
    return AsyncState<T>(
      status: status ?? this.status,
      data: data ?? this.data,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'AsyncState(status: $status, data: $data, error: $error)';
}
