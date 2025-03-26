import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';
import 'package:task_manager/core/global/widgets/decoration_box_widget.dart';
import 'package:task_manager/core/global/widgets/loading_indicators/circular_progress_indicator_widget.dart';
import 'package:task_manager/core/global/widgets/shrink_effect_wrapper.dart';
import 'package:task_manager/core/global/widgets/text_widget.dart';

class CommonRoundedButton extends StatelessWidget {
  const CommonRoundedButton({
    required this.borderRadius,
    required this.isLoading,
    required this.onTap,
    required this.label,
    required this.icon,
    this.iconColor,
    this.style,
    this.heroTag,
    this.expanded = false,
    this.contentPadding = const EdgeInsets.all(15),
    super.key,
  });

  final String label;
  final bool expanded;
  final IconData? icon;
  final bool isLoading;
  final Color? iconColor;
  final WidgetIdentifier? heroTag;
  final TextStyle? style;
  final VoidCallback onTap;
  final BorderRadius borderRadius;
  final EdgeInsets contentPadding;

  @override
  Widget build(BuildContext context) {
    final commonIconColor =
        iconColor ?? style?.color ?? context.theme.textTheme.labelLarge?.color;
    return Semantics(
      button: true,
      label: label,
      tooltip: label,
      hint: 'Tap to $label',
      child: ExcludeFocus(
        child: ExcludeSemantics(
          child: ShrinkEffectWrapper(
            onTap: _onTap,
            heroTag: heroTag,
            child: ExcludeSemantics(
              child: DecoratedBoxWidget(
                color: context.theme.cardColor,
                borderRadius: borderRadius,
                child: Padding(
                  padding: contentPadding,
                  child: Row(
                    mainAxisSize:
                        expanded ? MainAxisSize.max : MainAxisSize.min,
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: AnimatedCrossFade(
                          duration: const Duration(milliseconds: 200),
                          crossFadeState: isLoading
                              ? CrossFadeState.showSecond
                              : CrossFadeState.showFirst,
                          firstChild: TextWidget(
                            label,
                            style: style ?? context.theme.textTheme.labelLarge,
                            overflow: TextOverflow.ellipsis,
                          ),
                          secondChild: const SizedBox.shrink(),
                        ),
                      ),
                      AnimatedCrossFade(
                        duration: const Duration(milliseconds: 200),
                        crossFadeState: isLoading
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstChild: icon == null
                            ? const SizedBox.shrink()
                            : Icon(
                                icon,
                                color: commonIconColor,
                              ),
                        secondChild: CircularProgressIndicatorWidget(
                          dimension: 20,
                          strokeWidth: 2,
                          color: commonIconColor,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTap() {
    if (isLoading) return;
    return onTap();
  }
}
