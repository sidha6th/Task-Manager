import 'package:task_manager/core/global/models/task/task.dart';

abstract class ITaskCreationOrUpdationEvent {
  const ITaskCreationOrUpdationEvent();
}

class CreateOrUpdateTaskEvent extends ITaskCreationOrUpdationEvent {
  const CreateOrUpdateTaskEvent({
    required this.task,
    this.whenCompleted,
  });

  final Task task;
  final void Function(Task task)? whenCompleted;
}
