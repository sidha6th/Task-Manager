import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_state.dart';

class ThemeModeSelectorWidget extends StatefulWidget {
  const ThemeModeSelectorWidget({
    required this.onChange,
    super.key,
  });

  final void Function(ThemeMode? mode) onChange;

  @override
  State<ThemeModeSelectorWidget> createState() =>
      _ThemeModeSelectorWidgetState();
}

class _ThemeModeSelectorWidgetState extends State<ThemeModeSelectorWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      buildWhen: (previous, current) =>
          previous.data?.themeMode != current.data?.themeMode,
      builder: (context, state) {
        return Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              ThemeMode.values.length,
              (index) {
                final mode = ThemeMode.values[index];
                return RadioListTile(
                  title: Text(mode.name),
                  value: mode,
                  groupValue: state.data?.themeMode,
                  onChanged: widget.onChange,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
