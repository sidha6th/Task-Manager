import 'dart:async';

import 'package:drift/drift.dart';
import 'package:task_manager/core/database/database_client/database.dart';
import 'package:task_manager/core/database/tables/settings_table.dart';
import 'package:task_manager/core/database/tables/task_table.dart';
import 'package:task_manager/core/database/utils/extensions/settings_table_data_to_settings.dart';
import 'package:task_manager/core/database/utils/extensions/task_table_data_to_task.dart';
import 'package:task_manager/core/global/constants.dart';
import 'package:task_manager/core/global/extension/string_extension.dart';
import 'package:task_manager/core/global/models/settings/settings.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/models/task/task_filter_settings.dart';

part '../settings_table_client.dart';
part '../task_table_client.dart';

abstract base class ITableBaseClient<R extends HasResultSet, T extends Table,
    D extends DataClass> {
  const ITableBaseClient(this._database);

  final AppDatabase _database;

  Stream<List<D>> _watch(
    ResultSetImplementation<R, D> Function(AppDatabase database)
        selectTableFrom, {
    List<OrderingTerm Function(R)>? orderBy,
    Expression<bool> Function(R)? filter,
    int limit = Constants.tasksPerPage,
    int page = 0,
  }) {
    final offset = page * limit;
    final table = _database.select(selectTableFrom(_database));
    if (filter == null) {
      return (table
            ..orderBy(orderBy ?? [])
            ..limit(limit, offset: offset))
          .watch();
    }

    return (table
          ..where(filter)
          ..orderBy(orderBy ?? [])
          ..limit(limit, offset: offset))
        .watch();
  }

  Future<D?> _readSingleOrNull(
    ResultSetImplementation<R, D> Function(AppDatabase database)
        selectTableFrom, {
    Expression<bool> Function(R)? filter,
  }) {
    final table = _database.select(selectTableFrom(_database));
    if (filter == null) return (table..limit(1)).getSingleOrNull();

    return (table
          ..where(filter)
          ..limit(1))
        .getSingleOrNull();
  }

  Future<int> _write(
    TableInfo<T, D> Function(AppDatabase database) selectTableFrom,
    Insertable<D> entity,
  ) {
    return _database
        .into(selectTableFrom(_database))
        .insert(entity, mode: InsertMode.insertOrReplace);
  }

  Future<int> _delete(
    TableInfo<T, D> Function(AppDatabase database) selectTableFrom,
    Insertable<D> entity,
  ) {
    return _database.delete(selectTableFrom(_database)).delete(entity);
  }
}
