import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/global/enums/date_formates.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_navigation_extension.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_overlay_widget_extension.dart';
import 'package:task_manager/core/global/extension/date_time_extension.dart';
import 'package:task_manager/core/global/extension/form_state_extension.dart';
import 'package:task_manager/core/global/extension/string_extension.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/models/task/task_priorities.dart';
import 'package:task_manager/core/global/widgets/appbar/regular_appbar_widget.dart';
import 'package:task_manager/core/global/widgets/builder/bloc_provider_builder.dart';
import 'package:task_manager/core/global/widgets/button/bordered_rounded_button.dart';
import 'package:task_manager/core/global/widgets/text_field/text_form_field_widget.dart';
import 'package:task_manager/features/task_creation_or_updation/data/repository/task_creation_or_updation_repository.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/bloc/task_creation_or_updation_bloc.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/bloc/task_creation_or_updation_event.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/bloc/task_creation_or_updation_state.dart';
import 'package:task_manager/features/task_creation_or_updation/presentation/widgets/segmented_priority_selector.dart';

class TaskCreationOrUpdationPage extends StatefulWidget {
  const TaskCreationOrUpdationPage(
      {required this.saveButtonTag, super.key, this.task});

  final Task? task;
  final WidgetIdentifier saveButtonTag;

  @override
  State<TaskCreationOrUpdationPage> createState() =>
      _TaskCreationOrUpdationPageState();
}

class _TaskCreationOrUpdationPageState
    extends State<TaskCreationOrUpdationPage> {
  final duedateSelectorFocusNode = FocusNode();
  final prioritySelectorFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  TaskPriority selectedPriority = TaskPriority.low;
  late DateTime? dueDate = widget.task?.duedate;
  late final _titleController = TextEditingController(text: widget.task?.title);
  late final _descriptionController =
      TextEditingController(text: widget.task?.description);

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final forTaskCreate = widget.task == null;
    return BlocProviderBuilder(
      create: (context) => TaskCreationOrUpdationBloc(
          TaskCreationOrUpdationRepository(context.read())),
      builder: (context) {
        return Scaffold(
          appBar: const RegularAppBarWidget(
            title: 'Add Task',
            semanticLabel:
                'Add your task by filling title, Description (optional), Due date and task priority',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 16,
                  children: [
                    TextFormFieldWidget(
                      labelText: 'Title',
                      validator: _titleValidator,
                      controller: _titleController,
                      textInputAction: TextInputAction.next,
                    ),
                    TextFormFieldWidget(
                      maxLines: 4,
                      labelText: 'Description',
                      controller: _descriptionController,
                      textInputAction: TextInputAction.none,
                      onEditingComplete: () {},
                    ),
                    FocusScope(
                      skipTraversal: true,
                      child: Column(
                        spacing: 20,
                        children: [
                          Focus(
                            focusNode: prioritySelectorFocusNode,
                            child: PrioritySegmentedSelector(
                              priority: selectedPriority,
                              onChange: (priority) =>
                                  selectedPriority = priority,
                            ),
                          ),
                          Focus(
                            focusNode: duedateSelectorFocusNode,
                            child: BorderedRoundedButtonWidget(
                              semanticHint: dueDate == null
                                  ? 'Double tap to select due date'
                                  : 'Double tap to change due date',
                              semanticLabel: dueDate == null
                                  ? 'Select a due date'
                                  : 'Selected due date is ${dueDate?.format(DateFormates.MMMMd)} ',
                              label: 'DUE DATE: '.join(dueDate?.format(
                                      DateFormates.MMMMd,
                                      upperCased: true)) ??
                                  'Select Due Date',
                              onTap: _onTapSelectDueDate,
                              borderThickness: 2,
                              borderRadius: BorderRadius.circular(30),
                              key: WidgetIdentifier.dueDateSelector.key,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: BlocBuilder<TaskCreationOrUpdationBloc,
              TaskCreationOrUpdationState>(builder: (context, state) {
            final label = '${forTaskCreate ? 'Create' : 'Update'} Task';
            return ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 500),
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BorderedRoundedButtonWidget(
                    label: label,
                    borderThickness: 2,
                    semanticLabel: label,
                    isLoading: state.loading,
                    heroTag: widget.saveButtonTag,
                    onTap: () => _onTapAddTask(context),
                    semanticHint: 'double tap to $label',
                    key: WidgetIdentifier.taskSaveButton.key,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  void _onTapAddTask(BuildContext context) {
    if (_formKey.currentState!.isNotValidated()) return;
    if (dueDate == null) {
      return context.showSnackBar(
        content: 'Please select the due date',
        semanticLabel: 'Please select the due date',
      );
    }

    final task = Task.createOrCopy(
      duedate: dueDate!,
      existingTask: widget.task,
      priority: selectedPriority,
      status: widget.task?.status,
      title: _titleController.text,
      description: _descriptionController.text,
    );

    if (task == widget.task) {
      return context.showSnackBar(
        content: 'No changes to update 📑',
        semanticLabel: 'Not updated, no changes made to update the task',
      );
    }

    final event = CreateOrUpdateTaskEvent(
      task: task,
      whenCompleted: _whenTaskCreatedOrUpdated,
    );
    context.read<TaskCreationOrUpdationBloc>().add(event);
  }

  Future<void> _onTapSelectDueDate() async {
    final today = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      firstDate: today,
      currentDate: dueDate,
      lastDate: today.add(const Duration(days: 365)),
    );
    if (newDate == null) return;
    dueDate = newDate;
    await SemanticsService.announce(
      'Due date selected - ${dueDate?.format(DateFormates.MMMMd)}',
      TextDirection.ltr,
    );

    duedateSelectorFocusNode.unfocus();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      duedateSelectorFocusNode.focusInDirection(TraversalDirection.down);
      FocusScope.of(context).requestFocus(prioritySelectorFocusNode);
    });
  }

  String? _titleValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Title cannot be empty';

    return null;
  }

  void _whenTaskCreatedOrUpdated(Task task) {
    context.pop(task);
    context.showSnackBar(
      semanticLabel:
          'The task is ${widget.task == null ? 'created' : 'updated'} successfully',
      content:
          'Task ${widget.task == null ? 'created' : 'updated'} successfully 🎉',
    );
  }
}
