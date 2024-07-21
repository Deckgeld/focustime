import 'package:flutter/material.dart';

enum NameLockType { limitUsage, schedule, numberLaunch }
enum DayOfWeek { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

class LockType {
  final String id;
  final NameLockType type;
  final List<DayOfWeek> daysActive;
  final int? limit;
  final List<TimeOfDay>? hoursActive;
  final bool? isByBlock;


  LockType({
    required this.id,
    required this.type,
    required this.daysActive,
    this.limit,
    this.hoursActive,
    this.isByBlock,
  });
}