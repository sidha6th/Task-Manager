import 'package:task_manager/core/database/database_client/database.dart';
import 'package:task_manager/core/global/models/task/task.dart';

extension TaskTableDataExtension on TaskTableData {
  Task get toTask => Task(
        id: key,
        title: title,
        status: status,
        duedate: duedate,
        priority: priority,
        progress: progress,
        createdAt: createdAt,
        description: description,
      );
}
