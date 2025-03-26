import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:path_provider/path_provider.dart';
import 'package:task_manager/core/database/tables/settings_table.dart';
import 'package:task_manager/core/database/tables/task_table.dart';
import 'package:task_manager/core/global/models/task/task_priorities.dart';
import 'package:task_manager/core/global/models/task/task_status.dart';

part 'database.g.dart';

@DriftDatabase(tables: [TaskTable, SettingsTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'task_manager_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
