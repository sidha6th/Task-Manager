import 'package:drift/drift.dart';
import 'package:flutter/material.dart' show ThemeMode;

class SettingsTable extends Table {
  TextColumn get key => text().clientDefault(() => 'User Settings')();
  IntColumn get primaryColorCode => integer().clientDefault(() => 0)();
  IntColumn get themeMode => intEnum<ThemeMode>().clientDefault(() => 0)();

  @override
  // The `key` column is set as the primary key to ensure that only one row exists in the table.
  // Since the settings should always have a single entry, the key value remains constant.
  // If an insert operation is attempted when a row already exists, the existing row will be retained,
  // preventing duplicate entries in the table.
  Set<Column<Object>>? get primaryKey => {key};
}
