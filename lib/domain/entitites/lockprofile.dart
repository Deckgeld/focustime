import 'dart:typed_data';

import 'package:focustime/domain/entitites/locktype.dart';
import 'package:installed_apps/app_info.dart';

enum StateLockProfile { active, inactive, paused }

class LockProfile {
  final String id;
  final String title;
  final List<LockType> lockTypes;
  final StateLockProfile stateProfile;
  final List<AppInfo> apps;
  final bool isBlockNotifications;


  LockProfile({
    required this.id,
    this.title = 'Sin nombre',
    required this.lockTypes,
    required this.stateProfile,
    required this.apps,
    this.isBlockNotifications = false,
  });

  //copyWith method
  LockProfile copyWith({
    String? id,
    String? title,
    List<LockType>? lockTypes,
    StateLockProfile? stateProfile,
    List<AppInfo>? apps,
    bool? isBlockNotifications,
  }) {
    return LockProfile(
      id: id ?? this.id,
      title: title ?? this.title,
      lockTypes: lockTypes ?? this.lockTypes,
      stateProfile: stateProfile ?? this.stateProfile,
      isBlockNotifications: isBlockNotifications ?? this.isBlockNotifications, 
      apps: apps ?? this.apps,
    );
  }


  List<Uint8List?> getAppIcons() {
    return apps.map((app) => app.icon).toList();
  }
}