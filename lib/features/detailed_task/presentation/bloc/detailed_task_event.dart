import 'package:task_manager/core/global/models/task/task.dart';

abstract class IDetailedTaskEvent {
  const IDetailedTaskEvent({this.whenCompleted});

  final void Function(Task task)? whenCompleted;
}

class ToggleDetailedTaskStatusEvent extends IDetailedTaskEvent {
  const ToggleDetailedTaskStatusEvent({super.whenCompleted});
}

class AddDetailedTaskEvent extends IDetailedTaskEvent {
  const AddDetailedTaskEvent(this.task, {super.whenCompleted});

  final Task task;
}

class UpdateDetailedTaskProgressEvent extends IDetailedTaskEvent {
  const UpdateDetailedTaskProgressEvent({
    required this.progress,
    super.whenCompleted,
  });

  final double progress;
}
