import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getTemporaryPath() async => './temp';

  @override
  Future<String?> getApplicationSupportPath() async => './support';

  @override
  Future<String?> getLibraryPath() async => './library';

  @override
  Future<String?> getApplicationDocumentsPath() async => './documents';

  @override
  Future<String?> getDownloadsPath() async => './downloads';

  @override
  Future<String?> getExternalStoragePath() async => './storage';

  @override
  Future<List<String>?> getExternalCachePaths() async => ['./cache'];

  @override
  Future<List<String>?> getExternalStoragePaths({
    StorageDirectory? type,
  }) async =>
      ['./storage'];
}
