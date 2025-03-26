import 'package:flutter/material.dart';
import 'dart:math';

class ContrastChecker {
  /// Calculate relative luminance according to WCAG 2.1 specifications
  static double _getLuminance(Color color) {
    final List<double> colorChannels = [
      color.r / 255,
      color.g / 255,
      color.b / 255,
    ];

    final List<double> adjustedChannels = colorChannels.map((channel) {
      if (channel <= 0.03928) {
        return channel / 12.92;
      }
      return pow((channel + 0.055) / 1.055, 2.4).toDouble();
    }).toList();

    return 0.2126 * adjustedChannels[0] +
        0.7152 * adjustedChannels[1] +
        0.0722 * adjustedChannels[2];
  }

  /// Calculate contrast ratio between two colors
  static double getContrastRatio(Color foreground, Color background) {
    final double lumA = _getLuminance(foreground);
    final double lumB = _getLuminance(background);
    
    final double lighter = max(lumA, lumB);
    final double darker = min(lumA, lumB);
    
    return (lighter + 0.05) / (darker + 0.05);
  }

  /// Check if the contrast ratio meets WCAG AA standards
  static bool meetsWCAGAA({
    required Color foreground,
    required Color background,
    bool isLargeText = false,
  }) {
    final double ratio = getContrastRatio(foreground, background);
    return isLargeText ? ratio >= 3.0 : ratio >= 4.5;
  }

  /// Check if the contrast ratio meets WCAG AAA standards
  static bool meetsWCAGAAA({
    required Color foreground,
    required Color background,
    bool isLargeText = false,
  }) {
    final double ratio = getContrastRatio(foreground, background);
    return isLargeText ? ratio >= 4.5 : ratio >= 7.0;
  }
}