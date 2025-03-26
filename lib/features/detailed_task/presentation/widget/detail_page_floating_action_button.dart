import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/tooltip_and_semantics.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/models/task/task.dart';
import 'package:task_manager/core/global/widgets/button/rounded_button_widget.dart';
import 'package:task_manager/core/global/widgets/decoration_box_widget.dart';
import 'package:task_manager/core/global/widgets/shrink_effect_wrapper.dart';

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
                  ShrinkEffectWrapper(
                    onTap: () => onTapEdit(WidgetIdentifier.taskEditButton),
                    heroTag: WidgetIdentifier.taskEditButton,
                    tooltipOrSemantics: ToolTipOrSemantics.editTask,
                    child: Material(
                      color: Colors.transparent,
                      child: CircleAvatar(
                        maxRadius: 26,
                        child: Icon(
                          Icons.edit,
                          color: context.theme.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: CommonRoundedButton(
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
