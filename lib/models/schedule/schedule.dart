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
