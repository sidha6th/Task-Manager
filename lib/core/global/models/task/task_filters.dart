import 'package:task_manager/core/global/models/task/task_status.dart';

enum TaskFilters {
  all('All'),
  completed('Completed'),
  pending('Pending');

  const TaskFilters(this.name);

  final String name;

  TaskStatus get status =>
      isCompleted ? TaskStatus.completed : TaskStatus.inprogress;

  bool get isAll => this == TaskFilters.all;
  bool get isCompleted => this == TaskFilters.completed;
  bool get isPending => this == TaskFilters.pending;
}
