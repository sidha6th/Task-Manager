import 'package:flutter/material.dart';

class DecoratedBoxWidget extends StatelessWidget {
  const DecoratedBoxWidget({
    required this.child,
    this.borderRadius,
    this.color,
    super.key,
  });

  final Color? color;
  final Widget child;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(30),
        color: color,
      ),
      child: child,
    );
  }
}
