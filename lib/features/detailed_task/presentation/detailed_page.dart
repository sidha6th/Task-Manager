import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/global/enums/date_formates.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/bool_extension.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_navigation_extension.dart';
import 'package:task_manager/core/global/extension/date_time_extension.dart';
import 'package:task_manager/core/global/extension/scaffold_messenger_extension.dart';
import 'package:task_manager/core/global/extension/string_extension.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';
import 'package:task_manager/features/detailed_task/presentation/bloc/detailed_task_bloc.dart';
import 'package:task_manager/features/detailed_task/presentation/bloc/detailed_task_event.dart';
import 'package:task_manager/features/detailed_task/presentation/bloc/detailed_task_state.dart';
import 'package:task_manager/features/detailed_task/presentation/widget/detail_page_floating_action_button.dart';
import 'package:task_manager/features/detailed_task/presentation/widget/no_task_selected_indicator.dart';
import 'package:task_manager/features/detailed_task/presentation/widget/rounded_key_value_card_widget.dart';
import 'package:task_manager/features/detailed_task/presentation/widget/task_progress_indicator.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/task_creation__or_updation_page.dart';

class DetailedPage extends StatefulWidget {
  const DetailedPage({
    required this.task,
    super.key,
  });

  final Task? task;

  @override
  State<DetailedPage> createState() => _DetailedPageState();
}

class _DetailedPageState extends State<DetailedPage> {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  late var _task = widget.task;
  bool statusChanged = false;

  @override
  void initState() {
    if (widget.task != null) {
      _addTaskToState();
    }
    super.initState();
  }

  @override
  void didUpdateWidget(covariant DetailedPage oldWidget) {
    if (widget.task == null) return;
    _task = widget.task;
    _addTaskToState();

    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBar(),
        body: (_task == null).then(
          NoTaskSelectedIndicatorWidget.new,
          or: () {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: BlocBuilder<DetailedTaskBloc, DetailedTaskState>(
                            builder: (context, state) {
                          return TextWidget(
                            _task!.title,
                            margin: const EdgeInsets.only(bottom: 20),
                            style:
                                context.theme.textTheme.headlineLarge?.copyWith(
                              decoration:
                                  (state.data ?? _task)!.status.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(width: double.infinity),
                  if (_task!.description.hasNoData) ...{
                    TextWidget(
                      'No description added',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: context.theme.disabledColor,
                        fontSize: 15,
                      ),
                    ),
                  } else ...{
                    Row(
                      children: [
                        TextWidget(
                          'Description',
                          style: context.theme.textTheme.titleMedium,
                          margin: const EdgeInsets.only(bottom: 10),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        TextWidget(
                          _task!.description,
                          margin: const EdgeInsets.only(bottom: 10),
                        ),
                      ],
                    ),
                  },
                  const SizedBox(height: 20),
                  RoundedKeyValueCardWidget(
                    'DUE DATE',
                    icon: const Icon(Icons.flag_outlined),
                    value: _task!.duedate
                        .format(DateFormates.MMMMd, upperCased: true),
                  ),
                  const SizedBox(height: 12),
                  RoundedKeyValueCardWidget(
                    'PRIORITY',
                    value: _task!.priority.name.toUpperCase(),
                  ),
                  const SizedBox(height: 12),
                  RoundedKeyValueCardWidget(
                    'CREATED AT',
                    icon: const Icon(Icons.calendar_today),
                    value: _task!.createdAt
                        .format(DateFormates.MMMMd, upperCased: true),
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<DetailedTaskBloc, DetailedTaskState>(
                    buildWhen: (previous, current) =>
                        previous.data != current.data,
                    builder: (context, state) {
                      final progress = state.data?.currentProgress() ?? 0;
                      return TaskProgressIndicator(
                        animate: statusChanged,
                        currentProgress: progress,
                        onChangeProgress: (value) =>
                            _onChangeProgress(value, context),
                      );
                    },
                  )
                ],
              ),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: BlocBuilder<DetailedTaskBloc, DetailedTaskState>(
            builder: (context, state) {
          if (_task == null) return const SizedBox.shrink();
          return DetailPageFloatingActionButton(
            key: WidgetIdentifier.statusTogglingButton.key,
            isStatusTogglingInProcess: state.loading,
            onTapToggleTaskStatus: () => _onToggleTaskStatus(context),
            onTapEdit: (tag) => _onTapEdit(tag, context),
            task: state.data ?? _task!,
          );
        }),
      ),
    );
  }

  Future<void> _onTapEdit(WidgetIdentifier tag, BuildContext context) async {
    final updatedTask = await context.pushTo<Task>(
      TaskCreationOrUpdationPage(task: _task, saveButtonTag: tag),
    );
    if (updatedTask != null) setState(() => _task = updatedTask);
  }

  void _onToggleTaskStatus(BuildContext context) {
    statusChanged = true;
    context.read<DetailedTaskBloc>().add(
          ToggleDetailedTaskStatusEvent(
            whenCompleted: _whenTaskUpdate,
          ),
        );
  }

  void _onChangeProgress(double value, BuildContext context) {
    statusChanged = false;
    context.read<DetailedTaskBloc>().add(
          UpdateDetailedTaskProgressEvent(
            progress: value,
            whenCompleted: _whenTaskUpdate,
          ),
        );
  }

  void _whenTaskUpdate(Task task) {
    if (_task?.status != task.status) {
      _scaffoldMessengerKey.currentState?.snackBar(
        semanticLabel: task.status.isCompleted
            ? 'Task marked as completed'
            : 'Task marked as incompleted',
        content: task.status.isCompleted
            ? 'Marked as completed 🎉'
            : 'Keep going! 💪',
      );
    }
    _task = task;
  }

  void _addTaskToState() {
    context.read<DetailedTaskBloc>().add(AddDetailedTaskEvent(widget.task!));
  }
}
