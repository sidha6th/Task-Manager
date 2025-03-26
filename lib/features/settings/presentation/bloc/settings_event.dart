import 'package:flutter/material.dart';

abstract class ISettingsEvent {
  const ISettingsEvent();
}

class LoadSettingsEvent extends ISettingsEvent {}

class ChangeThemeModeEvent extends ISettingsEvent {
  const ChangeThemeModeEvent({
    required this.selectedThemeMode,
  });

  final ThemeMode selectedThemeMode;
}

class ChangePrimaryColorEvent extends ISettingsEvent {
  const ChangePrimaryColorEvent({
    required this.selectedColorCode,
  });

  final int selectedColorCode;
}
