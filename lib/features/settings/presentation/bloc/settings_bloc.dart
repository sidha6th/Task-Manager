import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/global/models/settings/settings.dart';
import 'package:task_manager/features/settings/data/repository/settings_repository.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_event.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_state.dart';

class SettingsBloc extends Bloc<ISettingsEvent, SettingsState> {
  SettingsBloc(this.repository) : super(const SettingsState.loading()) {
    on<LoadSettingsEvent>(_onLoadSettingsEvent);
    on<ChangeThemeModeEvent>(_onChangeThemeModeEvent);
    on<ChangePrimaryColorEvent>(_onChangePrimaryColorEvent);
  }

  final SettingsRepository repository;

  Future<void> _onLoadSettingsEvent(
    LoadSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final settings = await repository.loadSettings();
    emit(SettingsState.success(settings ?? Settings.create()));
  }

  void _onChangeThemeModeEvent(
    ChangeThemeModeEvent event,
    Emitter<SettingsState> emit,
  ) {
    if (event.selectedThemeMode == state.data?.themeMode) return;
    final newState = state.data!.copyWith(themeMode: event.selectedThemeMode);
    repository.update(newState);
    emit(SettingsState.success(newState));
  }

  void _onChangePrimaryColorEvent(
    ChangePrimaryColorEvent event,
    Emitter<SettingsState> emit,
  ) {
    if (event.selectedColorCode == state.data?.primaryColorCode) return;
    final newState =
        state.data!.copyWith(primaryColorCode: event.selectedColorCode);
    repository.update(newState);
    emit(SettingsState.success(newState));
  }
}
