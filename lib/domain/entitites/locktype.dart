enum NameLockType { limitUsage, schedule, numberLaunch }
enum DayOfWeek { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

class LockType {
  final NameLockType type;
  final int limit;
  final List<DayOfWeek> daysActive;
  final List<int>? hoursActive;


  LockType({
    required this.type,
    required this.limit,
    required this.daysActive,
    this.hoursActive,
  });
}