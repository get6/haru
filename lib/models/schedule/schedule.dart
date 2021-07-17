import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'schedule.g.dart';

@HiveType(typeId: 0)
class Schedule {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final TimeOfDay startTime;
  @HiveField(2)
  final TimeOfDay endTime;
  @HiveField(3)
  final DateTime createdAt;

  Schedule({
    required this.title,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
  });
}
