import 'package:task_manager/core/database/table_client/base/table_base_client.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/models/task/task_filter_settings.dart';

class HomeRepository {
  const HomeRepository(this._client);

  final TaskTableClient _client;

  Stream<List<Task>> watchTasks(int page,
      {required TaskFilterSettings filterSettings}) {
    return _client.watchTasks(page, filterSettings: filterSettings);
  }

  Future<void> createOrUpdate(Task task) {
    return _client.createOrUpdateTask(task.toTaskTableCompanion());
  }

  void delete(Task task) {
    _client.deleteTask(task.toTaskTableCompanion());
  }
}
