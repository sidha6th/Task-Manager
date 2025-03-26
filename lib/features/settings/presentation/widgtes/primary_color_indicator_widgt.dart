import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';

class PrimaryColorIndicatorWidget extends StatelessWidget {
  const PrimaryColorIndicatorWidget.withColorCode({
    required int this.colorCode,
    this.selected = false,
    this.semanticLabel,
    this.heroTag,
    this.onTap,
    super.key,
  }) : color = null;

  const PrimaryColorIndicatorWidget.withColor({
    required Color this.color,
    this.selected = false,
    this.semanticLabel,
    this.heroTag,
    this.onTap,
    super.key,
  }) : colorCode = null;

  final Color? color;
  final bool selected;
  final int? colorCode;
  final WidgetIdentifier? heroTag;
  final VoidCallback? onTap;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final child = Semantics(
      container: true,
      checked: selected,
      label: semanticLabel,
      focused: selected,
      excludeSemantics: semanticLabel == null,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: color ?? Color(colorCode!),
              borderRadius: BorderRadius.circular(6),
              border: selected
                  ? Border.all(
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: context.theme.colorScheme.inverseSurface,
                    )
                  : null,
            ),
            child: const SizedBox.square(
              dimension: 35,
            ),
          ),
        ),
      ),
    );

    if (heroTag == null) return child;

    return Hero(tag: heroTag!.name, child: child);
  }
}
