import 'package:drift/drift.dart';
import 'package:task_manager/core/global/models/task/task_priorities.dart';
import 'package:task_manager/core/global/models/task/task_status.dart';

class TaskTable extends Table {
  TextColumn get title => text()();
  DateTimeColumn get duedate => dateTime()();
  DateTimeColumn get createdAt => dateTime()();
  RealColumn get progress => real().nullable()();
  IntColumn get status => intEnum<TaskStatus>()();
  IntColumn get key => integer().autoIncrement()();
  TextColumn get description => text().nullable()();
  IntColumn get priority => intEnum<TaskPriority>()();
}
