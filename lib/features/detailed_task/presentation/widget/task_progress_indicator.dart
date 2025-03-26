import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class TaskProgressIndicator extends StatefulWidget {
  const TaskProgressIndicator({
    required this.currentProgress,
    required this.onChangeProgress,
    this.animate = true,
    super.key,
  });

  final double currentProgress;
  final bool animate;
  final void Function(double progress) onChangeProgress;

  @override
  State<TaskProgressIndicator> createState() => _TaskProgressIndicatorState();
}

class _TaskProgressIndicatorState extends State<TaskProgressIndicator> {
  late var shouldAnimate = widget.animate;

  @override
  void didUpdateWidget(covariant TaskProgressIndicator oldWidget) {
    shouldAnimate = widget.animate;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          'Task progress is ${(widget.currentProgress * 100).toInt()} percentage',
      hint: 'Slide to change the progress level',
      slider: true,
      child: ExcludeSemantics(
        child: Column(
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
                      thumbShape: SliderComponentShape.noOverlay,
                      overlayShape: SliderComponentShape.noThumb,
                    ),
                    child: TweenAnimationBuilder(
                      duration: !widget.animate
                          ? Duration.zero
                          : const Duration(milliseconds: 300),
                      onEnd: _whenAnimationCompleted,
                      tween: Tween(
                          begin: widget.currentProgress,
                          end: widget.currentProgress),
                      builder: (context, value, child) {
                        return Slider(
                          value: value,
                          onChanged: widget.onChangeProgress,
                        );
                      },
                    ),
                  ),
                ),
                TextWidget(
                  '${(widget.currentProgress * 100).toInt()}%',
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _whenAnimationCompleted() {
    shouldAnimate = false;
  }
}
