import 'package:focustime/domain/entitites/locktype.dart';

enum StateLockProfile { active, inactive, paused }

class LockProfile {
  final String id;
  final String title;
  final List<LockType> lockTypes;
  final StateLockProfile stateProfile;
  final List<String> appImageUrls;
  final bool isBlockNotifications;


  LockProfile({
    required this.id,
    this.title = 'Sin nombre',
    required this.lockTypes,
    required this.stateProfile,
    required this.appImageUrls,
    this.isBlockNotifications = false,
  });

  //copyWith method
  LockProfile copyWith({
    String? id,
    String? title,
    List<LockType>? lockTypes,
    StateLockProfile? stateProfile,
    List<String>? appImageUrls,
    bool? isBlockNotifications,
  }) {
    return LockProfile(
      id: id ?? this.id,
      title: title ?? this.title,
      lockTypes: lockTypes ?? this.lockTypes,
      stateProfile: stateProfile ?? this.stateProfile,
      appImageUrls: appImageUrls ?? this.appImageUrls,
      isBlockNotifications: isBlockNotifications ?? this.isBlockNotifications,
    );
  }
}