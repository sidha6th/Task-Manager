import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_navigation_extension.dart';
import 'package:task_manager/core/global/extension/scaffold_messenger_extension.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

extension BuildContextOverlayWidgetExtension on BuildContext {
  Future<T?> showAlertDialogBox<T>({
    required String title,
    required Widget content,
    String? semanticLabel,
  }) {
    return showDialog(
      context: this,
      builder: (context) {
        return AlertDialog.adaptive(
          semanticLabel: semanticLabel ?? title,
          title: TextWidget(title),
          content: content,
          actions: [
            TextButton(
              onPressed: context.pop,
              child: const TextWidget('Close'),
            )
          ],
        );
      },
    );
  }

  void showSnackBar({
    required String content,
    required String semanticLabel,
    VoidCallback? onTapUndo,
  }) {
    final messenger = scaffoldMessenger();
    messenger.snackBar(
      content: content,
      semanticLabel: semanticLabel,
      onTapUndo: onTapUndo,
    );
  }

  Future<T?> showModalBottomSheetWidget<T>(Widget child) {
    return showModalBottomSheet(
      context: this,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return child;
      },
    );
  }
}
