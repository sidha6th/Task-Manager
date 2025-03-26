import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/core/global/enums/date_formates.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_navigation_extension.dart';
import 'package:task_manager/core/global/extension/date_time_extension.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/widgets/decoration_box_widget.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';
import 'package:task_manager/features/detailed_task/presentation/detailed_page.dart';
import 'package:task_manager/features/home/presentation/bloc/home_bloc.dart';
import 'package:task_manager/features/home/presentation/bloc/home_event.dart';
import 'package:task_manager/features/home/presentation/widgets/dismissable_action_panel.dart';

class TaskListTile extends StatefulWidget {
  const TaskListTile({
    required this.task,
    required this.onDelete,
    required this.isSelected,
    required this.index,
    required this.tasksLength,
    this.onChangeTaskStatus,
    super.key,
  });

  final Task task;
  final int index;
  final bool isSelected;
  final int tasksLength;
  final VoidCallback onDelete;
  final void Function(Task task)? onChangeTaskStatus;

  @override
  State<TaskListTile> createState() => _TaskListTileState();
}

class _TaskListTileState extends State<TaskListTile> {
  bool reOrderable = false;
  late var status = widget.task.status;
  late var cachedChild = getChild();

  Widget getChild() => Semantics(
        label:
            'Item ${widget.index + 1} of ${widget.tasksLength}, Task title is ${widget.task.title}',
        hint: 'Double-tap to view details',
        value: widget.task.status.isCompleted ? 'Completed' : 'Pending',
        button: true,
        child: ExcludeSemantics(
          child: Card(
            child: Slidable(
              key: ValueKey('slidable-${widget.task.id}'),
              endActionPane: DismissableActionPane.status(
                status: widget.task.status,
                onDissmis: () => _onUpdateStatus(context),
              ),
              startActionPane: DismissableActionPane.delete(
                onDissmis: widget.onDelete,
              ),
              child: ListTile(
                minLeadingWidth: 0,
                contentPadding:
                    const EdgeInsets.only(bottom: 3, top: 3, right: 20),
                leading: GestureDetector(
                  onTapDown: _onStartReorder,
                  onTapUp: _onEndReorder,
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: SizedBox(
                      width: 30,
                      height: 70,
                      child: Icon(Icons.reorder_rounded),
                    ),
                  ),
                ),
                tileColor: widget.isSelected
                    ? context.theme.focusColor.withAlpha(30)
                    : null,
                focusColor: context.theme.focusColor.withAlpha(20),
                textColor: widget.task.status.isCompleted
                    ? context.theme.disabledColor
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minVerticalPadding: 10,
                onTap: () => _onTapTask(context),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(
                      widget.task.description,
                      maxLines: 2,
                      style: context.theme.textTheme.bodySmall,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: 16,
                      children: [
                        Flexible(
                          child: DecoratedBoxWidget(
                            color: context.theme.focusColor.withAlpha(25),
                            child: TextWidget(
                              widget.task.priority.name,
                              textScaler: TextScaler.noScaling,
                              style:
                                  context.theme.textTheme.labelSmall?.copyWith(
                                color: widget.task.status.isCompleted
                                    ? context.theme.disabledColor
                                    : null,
                              ),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            spacing: 1,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.flag,
                                color: context.theme.disabledColor,
                              ),
                              Flexible(
                                child: TextWidget(
                                  widget.task.duedate
                                      .format(DateFormates.MMMMd),
                                  textScaler: TextScaler.noScaling,
                                  style: context.theme.textTheme.labelSmall
                                      ?.copyWith(
                                    color: context.theme.disabledColor,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
                title: TextWidget(
                  widget.task.title,
                  style: TextStyle(
                    decoration: status.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    overflow: TextOverflow.ellipsis,
                    color:
                        status.isCompleted ? context.theme.disabledColor : null,
                  ),
                ),
                trailing: Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox.square(
                      dimension: 25,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        value: widget.task.currentProgress(),
                        color: widget.task.currentProgress() >= 1
                            ? Colors.green
                            : context.theme.primaryColor,
                      ),
                    ),
                    TextWidget(
                      '${(widget.task.currentProgress() * 100).toInt()}%',
                      style: context.theme.textTheme.bodySmall?.copyWith(
                        fontSize: 10,
                        color: widget.task.currentProgress() >= 1
                            ? null
                            : context.theme.disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  @override
  void didUpdateWidget(covariant TaskListTile oldWidget) {
    status = widget.task.status;
    cachedChild = getChild();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      key: ValueKey(widget.task.id),
      enabled: reOrderable,
      index: widget.index,
      child: cachedChild,
    );
  }

  void _onUpdateStatus(BuildContext context) {
    context.read<HomeBloc>().add(ToggleTaskStatusEvent(
          widget.task,
          whenCompleted: widget.onChangeTaskStatus,
        ));
  }

  void _onTapTask(BuildContext context) {
    context.when(
        onMobileView: () {
          context.pushTo(DetailedPage(task: widget.task));
        },
        orElse: () =>
            context.read<HomeBloc>().add(SelectTaskEvent(widget.task)));
  }

  void _onStartReorder(_) {
    if (reOrderable) return;
    setState(() => reOrderable = true);
  }

  void _onEndReorder(_) {
    if (!reOrderable) return;
    setState(() => reOrderable = false);
  }
}
