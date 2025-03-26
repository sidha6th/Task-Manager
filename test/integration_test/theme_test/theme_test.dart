import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path/path.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:task_manager/core/global/enums/widget_identifier.dart';
import 'package:task_manager/main.dart' as app;

import '../../utils/fake_path_providers.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    PathProviderPlatform.instance = FakePathProviderPlatform();
    // Set up golden file comparator
    final currentDirectory = Directory.current;
    final goldenPath = join(
      currentDirectory.path,
      'test',
      'integration_test',
      'theme_test',
      'goldens',
    );

    Directory(goldenPath).createSync(recursive: true);
    goldenFileComparator = LocalFileComparator(Uri.parse(goldenPath));
  });

  Future<void> changeTheme(WidgetTester tester, ThemeMode modeName) async {
    final settingsButton = find.byIcon(Icons.settings);
    await tester.tap(settingsButton);
    await tester.pumpAndSettle();

    // Find and tap theme toggle
    final themeToggleTile =
        find.byKey(WidgetIdentifier.themModeChangingTile.key);
    await tester.tap(themeToggleTile);
    await tester.pumpAndSettle();

    final themMode = find.text(modeName.name);
    await tester.tap(themMode);
    await tester.pumpAndSettle();

    final close = find.text('Close');
    await tester.tap(close);
    await tester.pumpAndSettle();

    final backButton = find.byTooltip('Back');
    await tester.tap(backButton);
    await tester.pumpAndSettle();
  }

  group('Theme Tests', () {
    testWidgets('App switches between light and dark themes correctly',
        (WidgetTester tester) async {
      await binding.setSurfaceSize(const Size(390, 844));

      app.main();
      await tester.pump();

      await tester.pumpAndSettle();
      await changeTheme(tester, ThemeMode.light);
      await tester.pumpAndSettle();

      // Take screenshot of light theme
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/light_theme.png'),
      );

      await changeTheme(tester, ThemeMode.dark);
      await tester.pumpAndSettle();
      // Take screenshot of dark theme
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('goldens/dark_theme.png'),
      );
    });
  });
}
