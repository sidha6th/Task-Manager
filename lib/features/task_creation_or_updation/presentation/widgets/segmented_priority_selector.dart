import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/models/task/task_priorities.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class PrioritySegmentedSelector extends StatefulWidget {
  const PrioritySegmentedSelector({
    required this.onChange,
    required this.priority,
    super.key,
  });

  final void Function(TaskPriority selectedPriority) onChange;
  final TaskPriority priority;

  @override
  State<PrioritySegmentedSelector> createState() =>
      _PrioritySegmentedSelectorState();
}

class _PrioritySegmentedSelectorState extends State<PrioritySegmentedSelector> {
  late var _selectedPriority = widget.priority;

  late final _segments = TaskPriority.values
      .map(
        (priority) => ButtonSegment(
          value: priority,
          label: TextWidget(priority.name),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        TextWidget(
          'PRIORITY',
          style: context.theme.textTheme.bodyMedium,
        ),
        SegmentedButton(
          segments: _segments,
          showSelectedIcon: false,
          selected: {_selectedPriority},
          expandedInsets: EdgeInsets.zero,
          onSelectionChanged: _onChangeSelection,
        ),
      ],
    );
  }

  void _onChangeSelection(Set<TaskPriority> newSelection) {
    final value = newSelection.first;
    widget.onChange(value);
    setState(() => _selectedPriority = value);
  }
}
