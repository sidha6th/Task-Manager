import 'package:flutter/material.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class SnackBarContentWidget extends StatelessWidget {
  const SnackBarContentWidget({
    required this.content,
    this.onTapUndo,
    super.key,
  });

  final String content;
  final VoidCallback? onTapUndo;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(child: TextWidget(content)),
        if (onTapUndo != null)
          TextButton(
            onPressed: onTapUndo,
            child: const TextWidget('UNDO'),
          ),
      ],
    );
  }
}
