part of 'base/table_base_client.dart';

final class TaskTableClient
    extends ITableBaseClient<$TaskTableTable, TaskTable, TaskTableData> {
  TaskTableClient(super.database);

  Stream<List<Task>> watchTasks(
    int page, {
    required TaskFilterSettings filterSettings,
  }) {
    return _watch(
      page: page,
      (database) => database.taskTable,
      orderBy: [
        (table) => OrderingTerm.asc(filterSettings.sortBy.sortOptionFrom(table))
      ],
      filter: (table) => Expression.and([
        if (!filterSettings.filterBy.isAll)
          table.status.equals(filterSettings.filterBy.status.index),
        if (filterSettings.searchQuery.hasData)
          table.title.contains(filterSettings.searchQuery!),
      ]),
    ).map((event) => List.from(event.map((e) => e.toTask)));
  }

  Future<int> createOrUpdateTask(TaskTableCompanion companion) {
    
    return _write((database) => database.taskTable, companion);
  }

  Future<int> deleteTask(TaskTableCompanion companion) {
    return _delete((database) => database.taskTable, companion);
  }
}
