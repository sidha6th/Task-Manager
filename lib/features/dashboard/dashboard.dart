import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/database/table_client/base/table_base_client.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/builder/bloc_provider_builder.dart';
import 'package:task_manager/core/global/widgets/colored_sized_box.dart';
import 'package:task_manager/core/global/widgets/view_port/view_port_builder.dart';
import 'package:task_manager/features/detailed_task/presentation/detailed_page.dart';
import 'package:task_manager/features/home/data/repository/home_repository.dart';
import 'package:task_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager/features/home/presentation/bloc/home_event.dart';
import 'package:task_manager/features/home/presentation/bloc/home_state.dart';
import 'package:task_manager/features/home/presentation/home_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProviderBuilder(
      create: (context) =>
          HomeBloc(HomeRepository(context.read<TaskTableClient>()))
            ..add(const LoadTasksEvent()),
      builder: (context) {
        return ViewPortBuilder(
          mobileView: HomePage.new,
          tabView: () => Row(
            children: [
              const Expanded(child: HomePage()),
              ColoredSizedBox(
                width: 0.2,
                height: context.height,
                color: context.theme.colorScheme.inverseSurface,
              ),
              Expanded(
                child: BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) {
                    return previous.currentlySelectedTask !=
                        current.currentlySelectedTask;
                  },
                  builder: (context, state) {
                    return DetailedPage(
                      task: state.currentlySelectedTask,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
