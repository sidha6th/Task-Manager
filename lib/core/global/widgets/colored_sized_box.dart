import 'package:flutter/material.dart';

class ColoredSizedBox extends StatelessWidget {
  const ColoredSizedBox({
    super.key,
    this.width,
    this.height,
    this.color = Colors.white,
    this.child,
  });

  final double? width;
  final double? height;
  final Color color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: color,
      child: SizedBox(
        height: height,
        width: width,
        child: child,
      ),
    );
  }
}
