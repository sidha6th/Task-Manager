import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class TaskProgressIndicator extends StatelessWidget {
  const TaskProgressIndicator({
    required this.progress,
    required this.onChangeProgress,
    super.key,
  });

  final double progress;
  final void Function(double progress) onChangeProgress;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        TextWidget(
          'Progress',
          style: context.theme.textTheme.titleMedium,
        ),
        Row(
          spacing: 10,
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 10,
                  thumbShape: SliderComponentShape.noThumb,
                  overlayShape: SliderComponentShape.noOverlay,
                ),
                child: TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 100),
                    tween: Tween(begin: progress, end: progress),
                    builder: (context, value, child) {
                      return Slider(
                        value: value,
                        onChanged: onChangeProgress,
                      );
                    }),
              ),
            ),
            TextWidget(
              '${(progress * 100).toInt()}%',
            )
          ],
        ),
      ],
    );
  }
}
