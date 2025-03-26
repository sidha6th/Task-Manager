import 'package:task_manager/core/database/table_client/base/table_base_client.dart';
import 'package:task_manager/core/global/models/settings/settings.dart';

class SettingsRepository {
  const SettingsRepository(this._client);

  final SettingsTableClient _client;

  Future<Settings?> loadSettings() => _client.readSettings();
  Future<void> update(Settings settings) => _client.write(settings);
}
