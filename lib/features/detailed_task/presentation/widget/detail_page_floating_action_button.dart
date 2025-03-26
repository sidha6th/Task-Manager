import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/tooltip_and_semantics.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/widgets/button/rounded_button_widget.dart';
import 'package:task_manager/core/global/widgets/button/rounded_fa_button.dart';
import 'package:task_manager/core/global/widgets/decoration_box_widget.dart';

class DetailPageFloatingActionButton extends StatelessWidget {
  const DetailPageFloatingActionButton({
    required this.isStatusTogglingInProcess,
    required this.onTapToggleTaskStatus,
    required this.onTapEdit,
    required this.task,
    super.key,
  });

  final VoidCallback onTapToggleTaskStatus;
  final void Function(WidgetIdentifier tag) onTapEdit;
  final Task task;
  final bool isStatusTogglingInProcess;

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(30);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DecoratedBoxWidget(
          color: context.theme.colorScheme.inverseSurface.withAlpha(230),
          borderRadius: borderRadius,
          child: SizedBox(
            width: context.width,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                spacing: 6,
                children: [
                  RoundedFAButton(
                    icon: Icons.edit,
                    onTap: onTapEdit,
                    semanticHint: 'double tap to edit task',
                    identifier: WidgetIdentifier.taskEditButton,
                    toolTipOrSemantics: ToolTipOrSemantics.editTask,
                  ),
                  Expanded(
                    child: CommonRoundedButton(
                      semanticHint:
                          'double tap to change the status to ${task.status.isCompleted ? 'incomplete' : 'completed'} ',
                      semanticLabel: task.status.isCompleted
                          ? 'MARK AS NOT COMPLETED'
                          : 'MARK AS COMPLETED',
                      borderRadius: borderRadius,
                      onTap: onTapToggleTaskStatus,
                      isLoading: isStatusTogglingInProcess,
                      icon: task.status.isCompleted
                          ? Icons.check_box_outline_blank_outlined
                          : Icons.check_box_outlined,
                      label: task.status.isCompleted
                          ? 'MARK AS NOT COMPLETED'
                          : 'MARK AS COMPLETED',
                      expanded: true,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
