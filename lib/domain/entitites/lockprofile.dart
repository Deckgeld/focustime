import 'package:focustime/domain/entitites/locktype.dart';

enum StateLockProfile { active, inactive, paused }

class LockProfile {
  final String id;
  final String title;
  final List<LockType> lockTypes;
  final StateLockProfile stateProfile;
  final List<String> appImageUrls;


  LockProfile({
    required this.id,
    required this.title,
    required this.lockTypes,
    required this.stateProfile,
    required this.appImageUrls,
  });

  //copyWith method
  LockProfile copyWith({
    String? id,
    String? title,
    List<LockType>? lockTypes,
    StateLockProfile? stateProfile,
    List<String>? appImageUrls,
  }) {
    return LockProfile(
      id: id ?? this.id,
      title: title ?? this.title,
      lockTypes: lockTypes ?? this.lockTypes,
      stateProfile: stateProfile ?? this.stateProfile,
      appImageUrls: appImageUrls ?? this.appImageUrls,
    );
  }
}