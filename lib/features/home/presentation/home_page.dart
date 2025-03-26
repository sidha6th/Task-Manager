import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/global/enums/tooltip_and_semantics.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_navigation_extension.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_overlay_widget_extension.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/models/task/task_filter_settings.dart';
import 'package:task_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager/features/home/presentation/bloc/home_event.dart';
import 'package:task_manager/features/home/presentation/bloc/home_state.dart';
import 'package:task_manager/features/home/presentation/widgets/add_task_fab_button_widget.dart';
import 'package:task_manager/features/home/presentation/widgets/filter_bottom_sheet_widget.dart';
import 'package:task_manager/features/home/presentation/widgets/home_app_bar.dart';
import 'package:task_manager/features/home/presentation/widgets/home_tasks_lists_holding_widget.dart';
import 'package:task_manager/features/settings/presentation/settings_page.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/task_creation__or_updation_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state.lastDeletedTask != null) {
          scaffoldKey.currentContext?.showSnackBar(
            content: 'Task deleted',
            semanticLabel: 'Task deleted',
            onTapUndo: () => context
                .read<HomeBloc>()
                .add(UndoDeletedTaskEvent(state.lastDeletedTask!)),
          );
        }
      },
      child: Scaffold(
        key: scaffoldKey,
        body: NotificationListener<ScrollNotification>(
          onNotification: (metrics) => _onNotification(metrics, context),
          child: CustomScrollView(
            slivers: [
              BlocBuilder<HomeBloc, HomeState>(
                  buildWhen: (previous, current) =>
                      current.isFilterApplied != previous.isFilterApplied,
                  builder: (context, state) {
                    return HomeAppbar(
                      isFilterApplied: state.isFilterApplied,
                      onTapFilter: () => _onTapAddFilter(context),
                      initialSearchValue: state.filterSettings.searchQuery,
                      onTapSettings: () => context.pushTo(const SettingsPage()),
                      onChangeSearchQuery: (query) =>
                          _searchTasks(query, context),
                    );
                  }),
              HomeTasksListHoldingWidget(
                onDeleteTask: _onDeleteTask,
                onChangeTaskStatus: (task) =>
                    _onChangeTaskStatus(context, task),
              )
            ],
          ),
        ),
        floatingActionButton:
            BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (!state.isFilterApplied && (state.loading || !state.hasData)) {
            return const SizedBox.shrink();
          }
          return RoundedFAButton(
            icon: Icons.add,
            semanticHint: 'Tap to add new task',
            identifier: WidgetIdentifier.taskAddFAButton,
            toolTipOrSemantics: ToolTipOrSemantics.addTask,
            onTap: (tag) => _pushToAddOrUpdatePage(tag, context),
          );
        }),
      ),
    );
  }

  void _onDeleteTask(int index, BuildContext context) {
    context.read<HomeBloc>().add(DeleteTaskEvent(index));
  }

  void _pushToAddOrUpdatePage(WidgetIdentifier tag, BuildContext context) {
    context.pushTo(TaskCreationOrUpdationPage(saveButtonTag: tag));
  }

  void _searchTasks(String? searchQuery, BuildContext context) {
    final filter = TaskFilterSettings.formSearch(searchQuery: searchQuery);
    return _loadTasks(context, filterSettings: filter);
  }

  void _onTapAddFilter(BuildContext context) {
    final state = context.read<HomeBloc>().state;
    scaffoldKey.currentContext?.showModalBottomSheetWidget(
      FilterBottomSheetWidget(
        selectedFilter: state.filterSettings.filterBy,
        selectedSort: state.filterSettings.sortBy,
        onApply: (settings) => _loadTasks(context, filterSettings: settings),
      ),
    );
  }

  bool _onNotification(ScrollNotification notification, BuildContext context) {
    if (notification.metrics.pixels + 10 >=
        notification.metrics.maxScrollExtent) {
      _loadTasks(context, reset: false);
    }
    return false;
  }

  void _loadTasks(
    BuildContext context, {
    TaskFilterSettings? filterSettings,
    bool reset = true,
  }) {
    context.read<HomeBloc>().add(
          LoadTasksEvent(
            resetPage: reset,
            filterSettings: filterSettings,
          ),
        );
  }

  void _onChangeTaskStatus(BuildContext context, Task task) {
    final message = task.status.isCompleted
        ? 'Marked as completed'
        : 'Marked as not completed';

    scaffoldKey.currentContext?.showSnackBar(
      content: message,
      semanticLabel: message,
    );
  }
}
