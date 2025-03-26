import 'package:flutter/material.dart';
import 'package:task_manager/core/theme/theme_utils.dart';

ThemeData darkTheme(Color primaryColor) => ThemeData(
      useMaterial3: true,
      primaryColor: primaryColor,
      colorScheme: ThemeUtils.createAccessibleColorScheme(
        primaryColor,
        Brightness.dark,
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 57),
        displayMedium: TextStyle(fontSize: 45),
        displaySmall: TextStyle(fontSize: 36),
        headlineLarge: TextStyle(fontSize: 32),
        headlineMedium: TextStyle(fontSize: 28),
        headlineSmall: TextStyle(fontSize: 24),
        titleLarge: TextStyle(fontSize: 22),
        titleMedium: TextStyle(fontSize: 16),
        titleSmall: TextStyle(fontSize: 14),
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12),
      ).apply(
        bodyColor: ThemeUtils.adjustColorForContrast(
          Colors.white,
          const Color(0xFF121212),
        ),
        displayColor: ThemeUtils.adjustColorForContrast(
          Colors.white,
          const Color(0xFF121212),
        ),
      ),
    );
