import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class NoTaskSelectedIndicatorWidget extends StatelessWidget {
  const NoTaskSelectedIndicatorWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextWidget(
                      'No Task Selected',
                      style: context.theme.textTheme.headlineMedium?.copyWith(
                        color: context.theme.disabledColor,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
