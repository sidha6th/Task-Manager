base class GlobalBlocState<T> {
  const GlobalBlocState({
    required this.loading,
    required this.success,
    this.data,
  });

  const GlobalBlocState.nil()
      : success = true,
        data = null,
        loading = false;

  const GlobalBlocState.error()
      : success = false,
        data = null,
        loading = false;

  const GlobalBlocState.success(T result)
      : success = true,
        data = result,
        loading = false;

  const GlobalBlocState.loading()
      : success = true,
        data = null,
        loading = true;

  final bool loading;
  final bool success;
  final T? data;

  bool get hasData => data != null;

  GlobalBlocState<T> toSuccess({T? task}) {
    return copyWith(
      success: true,
      loading: false,
      data: task,
    );
  }

  GlobalBlocState<T> toLoading() => copyWith(loading: true);

  GlobalBlocState<T> toError() => copyWith(success: false, loading: false);

  A when<A>({
    required A Function() loading,
    required A Function(T data) success,
    required A Function() error,
  }) {
    if (this.loading) return loading();
    if (this.success) return success(data as T);
    return error();
  }

  GlobalBlocState<T> copyWith({
    bool? loading,
    bool? success,
    T? data,
  }) {
    return GlobalBlocState<T>(
      loading: loading ?? this.loading,
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  @override
  bool operator ==(covariant GlobalBlocState<T> other) {
    if (identical(this, other)) return true;

    return other.loading == loading &&
        other.success == success &&
        other.data == data;
  }

  @override
  int get hashCode => loading.hashCode ^ success.hashCode ^ data.hashCode;
}
