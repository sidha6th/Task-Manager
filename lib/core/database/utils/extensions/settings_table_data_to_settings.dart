import 'package:task_manager/core/database/database_client/database.dart';
import 'package:task_manager/core/global/models/settings/settings.dart';

extension SettingsTableDataExtension on SettingsTableData {
  Settings get toSettings => Settings(
        primaryColorCode: primaryColorCode,
        themeMode: themeMode,
        key: key,
      );
}
