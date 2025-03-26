import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:task_manager/core/global/widgets/snack_bar_widget.dart';

extension ScaffoldMessengerStateExtension on ScaffoldMessengerState {
  void snackBar({
    required String content,
    required String semanticLabel,
    VoidCallback? onTapUndo,
  }) {
    SemanticsService.announce(semanticLabel, TextDirection.ltr);
    hideCurrentSnackBar();
    showSnackBar(
      SnackBar(
        content: SnackBarContentWidget(
          content: content,
          onTapUndo: onTapUndo != null
              ? () {
                  onTapUndo();
                  clearSnackBars();
                }
              : null,
        ),
      ),
    );
  }
}
