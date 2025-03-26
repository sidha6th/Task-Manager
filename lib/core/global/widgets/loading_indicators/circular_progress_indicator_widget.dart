import 'package:flutter/material.dart';

class CircularProgressIndicatorWidget extends StatelessWidget {
  const CircularProgressIndicatorWidget({
    this.strokeWidth = 4,
    this.dimension,
    this.color,
    super.key,
  });

  final double? dimension;
  final double strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: dimension,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Center(
          child: CircularProgressIndicator(
            color: color,
            strokeWidth: strokeWidth,
          ),
        ),
      ),
    );
  }
}
