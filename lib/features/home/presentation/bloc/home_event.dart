import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/models/task/task_filter_settings.dart';

abstract class IHomeEvent {
  const IHomeEvent({this.whenCompleted});

  final void Function(Task task)? whenCompleted;
}

class LoadTasksEvent extends IHomeEvent {
  const LoadTasksEvent({
    this.filterSettings,
    this.resetPage = true,
  });

  final bool resetPage;
  final TaskFilterSettings? filterSettings;
}

class ToggleTaskStatusEvent extends IHomeEvent {
  const ToggleTaskStatusEvent(this.task, {super.whenCompleted});

  final Task task;
}

class SelectTaskEvent extends IHomeEvent {
  const SelectTaskEvent(this.task);

  final Task task;
}

class DeleteTaskEvent extends IHomeEvent {
  const DeleteTaskEvent(this.index, {super.whenCompleted});

  final int index;
}

class UndoDeletedTaskEvent extends IHomeEvent {
  const UndoDeletedTaskEvent(this.task);

  final Task task;
}
