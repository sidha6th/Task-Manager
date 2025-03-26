import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/widgets/error/generic_error_widget.dart';
import 'package:task_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager/features/home/presentation/bloc/home_state.dart';
import 'package:task_manager/features/home/presentation/widgets/empty_tasks_view_widget.dart';
import 'package:task_manager/features/home/presentation/widgets/task_loading_indicator.dart';
import 'package:task_manager/features/home/presentation/widgets/task_tile_widget.dart';

class HomeTasksListHoldingWidget extends StatefulWidget {
  const HomeTasksListHoldingWidget({
    required this.onDeleteTask,
    required this.onChangeTaskStatus,
    super.key,
  });

  final void Function(int index, BuildContext context) onDeleteTask;
  final void Function(Task task) onChangeTaskStatus;

  @override
  State<HomeTasksListHoldingWidget> createState() =>
      _HomeTasksListHoldingWidgetState();
}

class _HomeTasksListHoldingWidgetState
    extends State<HomeTasksListHoldingWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (previous, current) {
        return previous.success != current.success ||
            previous.data != current.data ||
            previous.currentlySelectedTask?.id !=
                current.currentlySelectedTask?.id ||
            previous.loading != current.loading;
      },
      builder: (context, state) {
        return state.when(
          success: (tasks) {
            if (tasks.isEmpty) return EmptyTasksView(state: state);

            return SliverPadding(
              padding: const EdgeInsets.all(8),
              sliver: SliverPadding(
                padding: const EdgeInsets.only(bottom: 70),
                sliver: SliverReorderableList(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskListTile(
                      key: ValueKey('${task.id} - $index'),
                      task: task,
                      index: index,
                      tasksLength: tasks.length,
                      onChangeTaskStatus: widget.onChangeTaskStatus,
                      onDelete: () => widget.onDeleteTask(index, context),
                      isSelected: task.id == state.currentlySelectedTask?.id,
                    );
                  },
                  onReorder: (oldIndex, newIndex) {
                    if (newIndex > oldIndex) newIndex--;
                    setState(() {
                      final item = tasks.removeAt(oldIndex);
                      tasks.insert(newIndex, item);
                    });
                  },
                ),
              ),
            );
          },
          loading: () => const SliverFillRemaining(
            child: TasksLoadingIndicator(),
          ),
          error: () {
            return const SliverFillRemaining(
              child: GenericErrorWidget(),
            );
          },
        );
      },
    );
  }
}
