import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/models/task/task_filter_settings.dart';
import 'package:task_manager/core/global/state/paginated_global_bloc_state.dart';

final class HomeState extends PaginatedGlobalBlocState<Task> {
  const HomeState({
    required super.page,
    required super.loading,
    required super.success,
    required super.hasGotAllData,
    required super.isNextPageLoading,
    required this.filterSettings,
    this.currentlySelectedTask,
    this.lastDeletedTask,
    super.data,
  });

  const HomeState.error(
    super.page, {
    required this.filterSettings,
    this.currentlySelectedTask,
  })  : lastDeletedTask = null,
        super.error();

  const HomeState.success(
    super.value, {
    required super.page,
    required this.filterSettings,
    super.hasGotAllData,
    this.lastDeletedTask,
    this.currentlySelectedTask,
  }) : super.success();

  const HomeState.loading({
    this.filterSettings = const TaskFilterSettings.withDefault(),
    this.currentlySelectedTask,
  })  : lastDeletedTask = null,
        super.loading(0);

  const HomeState.loadingNextPage(
    super.page,
    super.data, {
    required this.filterSettings,
    this.currentlySelectedTask,
  })  : lastDeletedTask = null,
        super.nextPageLoading();

  final TaskFilterSettings filterSettings;
  final Task? lastDeletedTask;
  final Task? currentlySelectedTask;

  bool get isFilterApplied => filterSettings.filterApplied;

  @override
  HomeState toSuccess({
    List<Task>? task,
    bool reset = true,
    bool? hasGotAllData,
    Task? lastDeletedTask,
    Task? currentlySelectedTask,
    TaskFilterSettings? filterSettings,
    int? page,
  }) {
    return copyWith(
      page: page,
      data: task,
      success: true,
      loading: false,
      isNextPageLoading: false,
      hasGotAllData: hasGotAllData,
      filterSettings: filterSettings,
      lastDeletedTask: lastDeletedTask,
      currentlySelectedTask: currentlySelectedTask,
    );
  }

  @override
  HomeState toLoading({
    int page = 0,
    TaskFilterSettings? filterSettings,
  }) {
    return copyWith(
      page: page,
      loading: true,
      hasGotAllData: false,
      isNextPageLoading: false,
      filterSettings: filterSettings,
    );
  }

  @override
  HomeState toNextPageLoading({
    TaskFilterSettings? filterSettings,
    int? page,
  }) {
    return copyWith(
      page: page,
      loading: false,
      hasGotAllData: false,
      isNextPageLoading: true,
      filterSettings: filterSettings,
    );
  }

  @override
  HomeState toError() {
    return copyWith(
      success: false,
      loading: false,
      isNextPageLoading: false,
    );
  }

  @override
  HomeState copyWith({
    int? page,
    bool? loading,
    bool? success,
    List<Task>? data,
    bool? hasGotAllData,
    Task? lastDeletedTask,
    bool? isNextPageLoading,
    Task? currentlySelectedTask,
    TaskFilterSettings? filterSettings,
  }) {
    return HomeState(
      page: page ?? this.page,
      data: data ?? this.data,
      lastDeletedTask: lastDeletedTask,
      loading: loading ?? this.loading,
      success: success ?? this.success,
      hasGotAllData: hasGotAllData ?? this.hasGotAllData,
      filterSettings: filterSettings ?? this.filterSettings,
      currentlySelectedTask:
          currentlySelectedTask ?? this.currentlySelectedTask,
      isNextPageLoading: isNextPageLoading ?? this.isNextPageLoading,
    );
  }

  @override
  bool operator ==(covariant HomeState other) {
    if (identical(this, other)) return true;

    return other.data == data &&
        other.page == page &&
        other.loading == loading &&
        other.success == success &&
        other.hasGotAllData == hasGotAllData &&
        other.filterSettings == filterSettings &&
        other.lastDeletedTask == lastDeletedTask &&
        other.isNextPageLoading == isNextPageLoading &&
        other.currentlySelectedTask == currentlySelectedTask;
  }

  @override
  int get hashCode =>
      data.hashCode ^
      page.hashCode ^
      loading.hashCode ^
      success.hashCode ^
      hasGotAllData.hashCode ^
      filterSettings.hashCode ^
      lastDeletedTask.hashCode ^
      isNextPageLoading.hashCode ^
      currentlySelectedTask.hashCode;
}
