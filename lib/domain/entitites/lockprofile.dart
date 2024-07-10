import 'package:focustime/domain/entitites/locktype.dart';

enum StateLockProfile { active, inactive, paused }

class LockProfile {
  final String title;
  final List<LockType> lockTypes;
  final StateLockProfile state;
  final List<String> appImageUrls;


  LockProfile({
    required this.title,
    required this.lockTypes,
    required this.state,
    required this.appImageUrls,
  });
}