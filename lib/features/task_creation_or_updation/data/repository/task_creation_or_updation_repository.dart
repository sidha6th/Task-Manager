import 'package:task_manager/core/database/table_client/base/table_base_client.dart';
import 'package:task_manager/core/global/models/task/task.dart';

class TaskCreationOrUpdationRepository {
  const TaskCreationOrUpdationRepository(this._client);

  final TaskTableClient _client;

  Future<void> createOrUpdateTask(Task task) {
    return _client.createOrUpdateTask(task.toTaskTableCompanion());
  }
}
