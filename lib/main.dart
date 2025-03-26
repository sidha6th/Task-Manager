import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/app.dart';
import 'package:task_manager/core/database/database_client/database.dart';
import 'package:task_manager/core/database/table_client/base/table_base_client.dart';
import 'package:task_manager/core/global/widgets/builder/repository_provider_builder.dart';
import 'package:task_manager/features/detailed_task/data/repository/detailed_task_repository.dart';
import 'package:task_manager/features/detailed_task/presentation/bloc/detailed_task_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    RepositoryProviderBuilder(
      create: (context) => AppDatabase(),
      builder: (context) {
        final database = context.read<AppDatabase>();
        return MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => SettingsTableClient(database),
            ),
            RepositoryProvider(
              create: (context) => TaskTableClient(database),
            ),
          ],
          child: BlocProvider(
            create: (context) => DetailedTaskBloc(
              DetailedTaskRepository(context.read()),
            ),
            child: const App(),
          ),
        );
      },
    ),
  );
}
