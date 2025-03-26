import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:task_manager/core/global/models/task/task_status.dart';

class DismissableActionPane extends ActionPane {
  DismissableActionPane.delete({
    required this.onDissmis,
    super.key,
  }) : super(
          motion: const ScrollMotion(),
          dismissible: DismissiblePane(
            onDismissed: onDissmis,
            dismissThreshold: 0.1,
          ),
          children: [
            SlidableAction(
              flex: 2,
              onPressed: (_) => onDissmis(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        );

  DismissableActionPane.status({
    required this.onDissmis,
    required TaskStatus status,
    super.key,
  }) : super(
          motion: const ScrollMotion(),
          dragDismissible: false,
          children: [
            SlidableAction(
              flex: 2,
              onPressed: (_) => onDissmis(),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: status.isCompleted
                  ? Icons.check_box_outline_blank
                  : Icons.done,
              label:
                  'Mark as ${status.isInProgress ? 'completed' : 'not completed'}',
            ),
          ],
        );

  final VoidCallback onDissmis;
}
