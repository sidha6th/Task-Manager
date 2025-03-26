import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager/core/database/database_client/database.dart';
import 'package:task_manager/core/global/extension/string_extension.dart';
import 'package:task_manager/core/global/models/task/task_priorities.dart';
import 'package:task_manager/core/global/models/task/task_status.dart';

@immutable
class Task {
  const Task({
    required this.title,
    required this.status,
    required this.duedate,
    required this.priority,
    required this.progress,
    required this.createdAt,
    this.description,
    this.id,
  });

  Task.create({
    required this.title,
    required this.duedate,
    required this.priority,
    this.description,
    this.status = TaskStatus.inprogress,
  })  : id = null,
        progress = status.isCompleted ? 1 : 0,
        createdAt = DateTime.now();

  factory Task.createOrCopy({
    required String title,
    required DateTime duedate,
    required String description,
    required Task? existingTask,
    required TaskPriority priority,
    required TaskStatus? status,
  }) {
    if (existingTask == null) {
      return Task(
        title: title,
        progress: 0,
        duedate: duedate,
        priority: priority,
        description: description,
        createdAt: DateTime.now(),
        status: status ?? TaskStatus.inprogress,
      );
    }

    return existingTask.copyWith(
      title: title,
      status: status,
      duedate: duedate,
      priority: priority,
      description: description,
    );
  }

  final int? id;
  final String title;
  final double? progress;
  final DateTime duedate;
  final TaskStatus status;
  final DateTime createdAt;
  final String? description;
  final TaskPriority priority;

  DateTime get createAtWithOutTime => createdAt.copyWith(hour: 0, minute: 0);
  DateTime get dueDateWithOutTime => duedate.copyWith(hour: 23, minute: 59);

  double currentProgress() {
    if (status.isCompleted) return 1;
    if (status.isInProgress && progress == 1) return 0.9;
    return progress ?? 0;
  }

  Task statusToggledTask() {
    return copyWith(
      status: status.isCompleted ? TaskStatus.inprogress : TaskStatus.completed,
    );
  }

  Task progressUpdatedTask(double progress) {
    return copyWith(
      progress: progress > 9.0 ? 1 : progress,
      status: progress >= 1 ? TaskStatus.completed : TaskStatus.inprogress,
    );
  }

  TaskTableCompanion toTaskTableCompanion() {
    return TaskTableCompanion.insert(
      title: title,
      status: status,
      duedate: duedate,
      priority: priority,
      createdAt: createdAt,
      key: Value.absentIfNull(id),
      progress: Value.absentIfNull(progress),
      description: Value.absentIfNull(description),
    );
  }

  TaskStatus getStatusBasedOnTime() {
    final isInProgress = DateTime.now().isAfter(duedate);
    if (isInProgress) return TaskStatus.inprogress;
    return TaskStatus.completed;
  }

  Task copyWith({
    String? title,
    double? progress,
    DateTime? duedate,
    TaskStatus? status,
    DateTime? createdAt,
    String? description,
    TaskPriority? priority,
  }) {
    return Task(
      id: id,
      status: status ?? this.status,
      duedate: duedate ?? this.duedate,
      progress: progress ?? this.progress,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      title: title.hasData ? title! : this.title,
      description: description.hasData ? description : this.description,
    );
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.title == title &&
        other.progress == progress &&
        other.duedate == duedate &&
        other.createdAt == createdAt &&
        other.description == description &&
        other.priority == priority &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        progress.hashCode ^
        duedate.hashCode ^
        createdAt.hashCode ^
        description.hashCode ^
        priority.hashCode ^
        status.hashCode;
  }
}
