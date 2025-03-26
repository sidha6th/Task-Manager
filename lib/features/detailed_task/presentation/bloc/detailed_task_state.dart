import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/state/global_bloc_state.dart';

final class DetailedTaskState extends GlobalBlocState<Task?> {
  const DetailedTaskState({
    required super.loading,
    required super.success,
    super.data,
  });

  const DetailedTaskState.error() : super.error();
  const DetailedTaskState.success(super.value) : super.success();
  const DetailedTaskState.loading() : super.loading();

  @override
  DetailedTaskState toSuccess({Task? task}) {
    return copyWith(success: true, data: task, loading: false);
  }

  @override
  DetailedTaskState toLoading({int page = 0}) {
    return copyWith(loading: true);
  }

  @override
  DetailedTaskState toError() {
    return copyWith(
      success: false,
      loading: false,
    );
  }

  @override
  DetailedTaskState copyWith({
    bool? loading,
    bool? success,
    Task? data,
  }) {
    return DetailedTaskState(
      loading: loading ?? this.loading,
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }
}
