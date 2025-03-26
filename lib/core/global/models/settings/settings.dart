import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/core/database/database_client/database.dart';
import 'package:task_manager/core/global/enums/primary_colors.dart';

class Settings {
  const Settings({
    required this.key,
    required this.themeMode,
    required this.primaryColorCode,
  });

  Settings.create()
      : key = 'User Settings',
        themeMode = ThemeMode.system,
        primaryColorCode = PrimaryColors.cyan.colorCode;

  final String key;
  final ThemeMode themeMode;
  final int primaryColorCode;

  SettingsTableCompanion toCompanion() {
    return SettingsTableCompanion(
      primaryColorCode: Value(primaryColorCode),
      themeMode: Value(themeMode),
    );
  }

  Settings copyWith({
    String? key,
    ThemeMode? themeMode,
    int? primaryColorCode,
  }) {
    return Settings(
      key: key ?? this.key,
      themeMode: themeMode ?? this.themeMode,
      primaryColorCode: primaryColorCode ?? this.primaryColorCode,
    );
  }
}
