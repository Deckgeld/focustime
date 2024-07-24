import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'apps_installed_provider.g.dart';

@Riverpod(keepAlive: true)
class AppsInstalled extends _$AppsInstalled {
  List<AppInfo>? _cachedApps;

  @override
  Future<List<AppInfo>> build() async {
    if (_cachedApps != null) {
      return _cachedApps!;
    }
    return await loadApps();
  }

  Future<List<AppInfo>> loadApps() async {
    try {
      if (_cachedApps == null) {
        final installedApps = await InstalledApps.getInstalledApps(true, true);
        _cachedApps = installedApps;
      }
      return _cachedApps!;
    } catch (e) {
      throw Exception('Error al obtener las aplicaciones instaladas: $e');
    }
  }
}