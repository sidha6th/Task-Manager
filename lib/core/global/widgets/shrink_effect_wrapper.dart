import 'package:flutter/material.dart';
import 'package:task_manager/core/global/enums/tooltip_and_semantics.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';

class ShrinkEffectWrapper extends StatefulWidget {
  const ShrinkEffectWrapper({
    required this.child,
    this.sematicHint,
    this.shrinkDuration = const Duration(milliseconds: 100),
    this.tapDownScale = 0.95,
    this.tooltipOrSemantics,
    this.heroTag,
    this.onTap,
    super.key,
  });

  final Widget child;
  final VoidCallback? onTap;
  final double tapDownScale;
  final Duration shrinkDuration;
  final String? sematicHint;
  final WidgetIdentifier? heroTag;
  final ToolTipOrSemantics? tooltipOrSemantics;

  @override
  State<ShrinkEffectWrapper> createState() => _ShrinkEffectWrapperState();
}

class _ShrinkEffectWrapperState extends State<ShrinkEffectWrapper> {
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    Widget child = ExcludeSemantics(
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: _scaleDown,
        onTapUp: _scaleToNormal,
        onLongPressDown: _scaleDown,
        onLongPressUp: () => _scaleToNormal(null),
        child: AnimatedScale(
          scale: _scale,
          curve: Curves.easeIn,
          duration: widget.shrinkDuration,
          child: widget.child,
        ),
      ),
    );

    if (widget.tooltipOrSemantics != null) {
      child = Semantics(
        label: widget.tooltipOrSemantics?.semanticLabel,
        tooltip: widget.tooltipOrSemantics?.toolTip,
        hint: widget.sematicHint,
        button: true,
        child: child,
      );
    }

    if (widget.heroTag == null) return child;

    return Hero(tag: widget.heroTag!.name, child: child);
  }

  void _scaleToNormal(dynamic _) => setState(() => _scale = 1);
  void _scaleDown(dynamic _) => setState(() => _scale = widget.tapDownScale);
}
