import 'package:task_manager/core/global/extension/string_extension.dart';
import 'package:task_manager/core/global/models/task/task_filters.dart';
import 'package:task_manager/core/global/models/task/task_sort_options.dart';

class TaskFilterSettings {
  const TaskFilterSettings({
    required this.sortBy,
    required this.filterBy,
    this.searchQuery,
  });

  const TaskFilterSettings.withDefault({
    this.sortBy = TaskSortOptions.alphabetically,
    this.filterBy = TaskFilters.all,
    this.searchQuery,
  });

  const TaskFilterSettings.fromFilter({
    this.sortBy = TaskSortOptions.alphabetically,
    this.filterBy = TaskFilters.all,
  }) : searchQuery = null;

  const TaskFilterSettings.formSearch({
    required this.searchQuery,
  })  : sortBy = TaskSortOptions.alphabetically,
        filterBy = TaskFilters.all;

  final String? searchQuery;
  final TaskFilters filterBy;
  final TaskSortOptions sortBy;

  bool get filterApplied {
    return searchQuery.hasData ||
        sortBy != TaskSortOptions.alphabetically ||
        filterBy != TaskFilters.all;
  }

  TaskFilterSettings copyLatest(TaskFilterSettings? settings) {
    final filterBy = settings?.filterBy;
    final sortBy = settings?.sortBy;
    final searchQuery = settings?.searchQuery;
    final applyPreviousFilter = searchQuery != null;

    return TaskFilterSettings(
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: applyPreviousFilter ? this.sortBy : (sortBy ?? this.sortBy),
      filterBy:
          applyPreviousFilter ? this.filterBy : (filterBy ?? this.filterBy),
    );
  }

  @override
  String toString() =>
      'TaskFilterSettings(searchQuery: $searchQuery, filterBy: $filterBy, sortBy: $sortBy)';

  @override
  bool operator ==(covariant TaskFilterSettings other) {
    if (identical(this, other)) return true;

    return other.searchQuery == searchQuery &&
        other.filterBy == filterBy &&
        other.sortBy == sortBy;
  }

  @override
  int get hashCode =>
      searchQuery.hashCode ^ filterBy.hashCode ^ sortBy.hashCode;
}
