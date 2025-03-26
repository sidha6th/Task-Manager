part of 'base/table_base_client.dart';

final class SettingsTableClient extends ITableBaseClient<$SettingsTableTable,
    SettingsTable, SettingsTableData> {
  SettingsTableClient(super.database);

  Future<Settings?> readSettings() async {
    final tableData =
        await _readSingleOrNull((database) => database.settingsTable);
    return tableData?.toSettings;
  }

  Future<int> write(Settings settings) {
    return _write((database) => database.settingsTable, settings.toCompanion());
  }
}
