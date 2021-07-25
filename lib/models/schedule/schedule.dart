import 'package:haru/common/const_values.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'schedule.g.dart';

@HiveType(typeId: 0)
class Schedule {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final int color;
  @HiveField(2)
  final DateTime startTime;
  @HiveField(3)
  final DateTime endTime;
  @HiveField(4)
  final DateTime createdAt;

  Schedule({
    required this.title,
    required this.color,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
  });
}

final scheduleBoxProvider =
    StateProvider<Box<Schedule>>((ref) => Hive.box(scheduleBox));

final scheduleRepositoryProvider =
    Provider((ref) => ScheduleRepository(ref.read));

class ScheduleRepository {
  ScheduleRepository(this.read);

  final Reader read;

  List<Schedule> fetchSchedules() {
    final Box<Schedule> storeData = read(scheduleBoxProvider).state;
    return storeData.keys
        .cast<int>()
        .map((key) => storeData.get(key)!)
        .toList();
  }

  List<Schedule> fetchTodaySchedules() {
    final Box<Schedule> storeData = read(scheduleBoxProvider).state;
    return storeData.keys
        .cast<int>()
        .where((key) {
          final schedule = storeData.get(key);
          final today = DateTime.now();
          final startTime =
              DateTime(today.year, today.month, today.day - 1, 23, 59);
          final endTime = DateTime(today.year, today.month, today.day + 1);
          return schedule!.startTime.isAfter(startTime) &&
              schedule.endTime.isBefore(endTime);
        })
        .map((key) => storeData.get(key)!)
        .toList();
  }
}
