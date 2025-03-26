import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_overlay_widget_extension.dart';
import 'package:task_manager/core/global/widgets/appbar/regular_appbar_widget.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_event.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_state.dart';
import 'package:task_manager/features/settings/presentation/widgtes/primary_color_indicator_widgt.dart';
import 'package:task_manager/features/settings/presentation/widgtes/primary_color_selector_widget.dart';
import 'package:task_manager/features/settings/presentation/widgtes/theme_mode_selector_widget.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const RegularAppBarWidget(
          title: 'Settings',
          semanticLabel: 'Change you theme mode or change your primary color',
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Card(
              child: ListTile(
                key: WidgetIdentifier.themModeChangingTile.key,
                leading: const Icon(Icons.brightness_6),
                title: const Text('Theme Mode'),
                subtitle: const Text('Light / Dark / System'),
                onTap: () => _onTapSelectThemeMode(context),
              ),
            ),
            Card(
              child: ListTile(
                key: WidgetIdentifier.primaryColorChanginTile.key,
                leading: const Icon(Icons.color_lens),
                title: const Text('Primary Color'),
                subtitle: const Text('Customize app theme color'),
                trailing: BlocBuilder<SettingsBloc, SettingsState>(
                  buildWhen: (previous, current) =>
                      previous.data?.primaryColorCode !=
                      current.data?.primaryColorCode,
                  builder: (context, state) {
                    return PrimaryColorIndicatorWidget.withColor(
                      heroTag: WidgetIdentifier.primaryColorIndicator,
                      color: context.theme.primaryColor,
                    );
                  },
                ),
                onTap: () => _onTapSelectPrimaryColor(context),
              ),
            ),
          ],
        ));
  }

  void _onTapSelectThemeMode(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    context.showAlertDialogBox(
      title: 'Choose theme',
      content: ThemeModeSelectorWidget(
        onChange: (mode) {
          if (mode == null) return;
          bloc.add(ChangeThemeModeEvent(selectedThemeMode: mode));
        },
      ),
    );
  }

  void _onTapSelectPrimaryColor(BuildContext context) {
    final bloc = context.read<SettingsBloc>();
    context.showAlertDialogBox(
      title: 'Primary Color',
      semanticLabel: 'Choose primary color',
      content: PrimaryColorSelectorWidget(
        selecteColorCode: bloc.state.data?.primaryColorCode,
        onChange: (colorCode) => bloc.add(
          ChangePrimaryColorEvent(
            selectedColorCode: colorCode,
          ),
        ),
      ),
    );
  }
}
