import 'package:flutter/material.dart';

enum NameLockType { limitUsage, schedule, numberLaunch }
enum DayOfWeek { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

class LockType {
  final NameLockType type;
  final List<DayOfWeek> daysActive;
  final int? limit;
  final List<TimeOfDay>? hoursActive;


  LockType({
    required this.type,
    required this.daysActive,
    this.limit,
    this.hoursActive,
  });
}