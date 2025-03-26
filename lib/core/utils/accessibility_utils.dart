import 'dart:math' as math;

import 'package:flutter/material.dart';

class AccessibilityUtils {
  /// Calculate relative luminance as per WCAG 2.1
  static double _getRelativeLuminance(Color color) {
    double normalizeChannel(int value) {
      double normalized = value / 255;
      return normalized <= 0.03928
          ? normalized / 12.92
          : math.pow((normalized + 0.055) / 1.055, 2.4).toDouble();
    }

    final r = normalizeChannel(color.r.toInt());
    final g = normalizeChannel(color.g.toInt());
    final b = normalizeChannel(color.b.toInt());

    return 0.2126 * r + 0.7152 * g + 0.0722 * b;
  }

  /// Calculate contrast ratio between two colors
  static double getContrastRatio(Color foreground, Color background) {
    final double l1 = _getRelativeLuminance(foreground);
    final double l2 = _getRelativeLuminance(background);

    final lighter = math.max(l1, l2);
    final darker = math.min(l1, l2);

    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Check if colors meet WCAG AA contrast requirements
  static bool meetsWCAGAA({
    required Color foreground,
    required Color background,
    bool isLargeText = false,
  }) {
    final ratio = getContrastRatio(foreground, background);
    return isLargeText ? ratio >= 3.0 : ratio >= 4.5;
  }

  /// Check if colors meet WCAG AAA contrast requirements
  static bool meetsWCAGAAA({
    required Color foreground,
    required Color background,
    bool isLargeText = false,
  }) {
    final ratio = getContrastRatio(foreground, background);
    return isLargeText ? ratio >= 4.5 : ratio >= 7.0;
  }

  /// Get contrast level description
  static String getContrastLevel(double ratio) {
    if (ratio >= 7.0) return 'AAA (High Contrast)';
    if (ratio >= 4.5) return 'AA (Good Contrast)';
    if (ratio >= 3.0) return 'AA Large Text Only';
    return 'Insufficient Contrast';
  }
}
