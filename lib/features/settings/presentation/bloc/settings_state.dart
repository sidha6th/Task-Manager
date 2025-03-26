import 'package:task_manager/core/global/models/settings/settings.dart';
import 'package:task_manager/core/global/state/global_bloc_state.dart';

base class SettingsState extends GlobalBlocState<Settings> {
  const SettingsState.error() : super.error();
  const SettingsState.success(super.value) : super.success();
  const SettingsState.loading() : super.loading();
}
