import 'package:flutter/material.dart';
import 'package:task_manager/core/global/extension/build_context/build_context_extension.dart';

class TextWidget extends StatelessWidget {
  const TextWidget(
    this.data, {
    this.autoFocus = false,
    this.margin = EdgeInsets.zero,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap = true,
    this.overflow,
    this.maxLines,
    this.semanticsLabel,
    this.textHeightBehavior,
    this.selectionColor,
    this.strutStyle,
    this.textScaler,
    this.textWidthBasis,
    this.fallbackWidget,
    this.heroTag,
    super.key,
  });

  final String? data;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final String? semanticsLabel;
  final TextHeightBehavior? textHeightBehavior;
  final Color? selectionColor;
  final StrutStyle? strutStyle;
  final TextScaler? textScaler;
  final TextWidthBasis? textWidthBasis;
  final Widget? fallbackWidget;
  final EdgeInsets margin;
  final bool autoFocus;
  final String? heroTag;

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.trim().isEmpty) {
      return fallbackWidget ?? const SizedBox.shrink();
    }

    final text = Padding(
      padding: margin,
      child: Focus(
        autofocus: autoFocus,
        child: Text(
          data!,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel ?? data,
          textHeightBehavior: textHeightBehavior,
          selectionColor: selectionColor,
          strutStyle: strutStyle,
          textScaler:
              textScaler ?? TextScaler.linear(context.textScaler.scale(1)),
          textWidthBasis: textWidthBasis,
        ),
      ),
    );

    if (heroTag == null) return text;

    return Hero(
      tag: heroTag!,
      child: Material(
        color: Colors.transparent,
        child: text,
      ),
    );
  }
}
