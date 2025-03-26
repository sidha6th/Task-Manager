import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/global/enums/primary_colors.dart';
import 'package:task_manager/core/global/widgets/builder/bloc_provider_builder.dart';
import 'package:task_manager/core/theme/dark.dart';
import 'package:task_manager/core/theme/light.dart';
import 'package:task_manager/features/settings/data/repository/settings_repository.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_event.dart';
import 'package:task_manager/features/settings/presentation/bloc/settings_state.dart';
import 'package:task_manager/features/splash/presentation/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProviderBuilder(
      create: (context) => SettingsBloc(SettingsRepository(context.read()))
        ..add(LoadSettingsEvent()),
      builder: (context) {
        return BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final data = state.data;
            final primaryColor = Color(
                data?.primaryColorCode ?? PrimaryColors.values.first.colorCode);
            return MaterialApp(
              theme: lightTheme(primaryColor),
              darkTheme: darkTheme(primaryColor),
              themeMode: data?.themeMode ?? ThemeMode.system,
              home: SplashPage(isSetupDone: !state.loading),
            );
          },
        );
      },
    );
  }
}
