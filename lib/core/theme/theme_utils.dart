import 'package:flutter/material.dart';
import 'package:task_manager/core/utils/contrast_checker.dart';

class ThemeUtils {
  /// Adjusts color brightness to meet contrast requirements
  static Color adjustColorForContrast(Color color, Color background,
      {bool isLargeText = false}) {
    if (ContrastChecker.meetsWCAGAA(
      foreground: color,
      background: background,
      isLargeText: isLargeText,
    )) {
      return color;
    }

    final HSLColor hslColor = HSLColor.fromColor(color);
    final bool isDarkBackground = background.computeLuminance() < 0.5;

    double newLightness = hslColor.lightness;
    while (ContrastChecker.meetsWCAGAA(
      foreground: hslColor.withLightness(newLightness).toColor(),
      background: background,
      isLargeText: isLargeText,
    )) {
      newLightness = isDarkBackground
          ? (newLightness + 0.05).clamp(0.0, 1.0)
          : (newLightness - 0.05).clamp(0.0, 1.0);
    }

    return hslColor.withLightness(newLightness).toColor();
  }

  /// Creates an accessible color scheme from a primary color
  static ColorScheme createAccessibleColorScheme(
      Color primaryColor, Brightness brightness) {
    final bool isDark = brightness == Brightness.dark;
    final Color background = isDark ? const Color(0xFF121212) : Colors.white;

    // Adjust primary color for contrast if needed
    final Color adjustedPrimary = adjustColorForContrast(
      primaryColor,
      background,
      isLargeText: true,
    );

    return ColorScheme.fromSeed(
      seedColor: adjustedPrimary,
      brightness: brightness,
      primary: adjustedPrimary,
      background: background,
      // Ensure surface colors have proper contrast
      surface: isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
      onPrimary: adjustColorForContrast(
        isDark ? Colors.black : Colors.white,
        adjustedPrimary,
      ),
      onSurface: adjustColorForContrast(
        isDark ? Colors.white : Colors.black,
        isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF5F5F5),
      ),
    );
  }
}
