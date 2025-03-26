import 'dart:io';
import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:task_manager/main.dart' as app;

import '../../../utils/fake_path_providers.dart';

Future<void> initTest(IntegrationTestWidgetsFlutterBinding binding) async {
  if (!Platform.isAndroid && !Platform.isIOS) {
    PathProviderPlatform.instance = FakePathProviderPlatform();
  }

  await binding.setSurfaceSize(const Size(800, 1200));
  app.main();
  await binding.pump();
}
