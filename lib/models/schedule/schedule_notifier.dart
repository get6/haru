import 'package:flutter/material.dart';
import 'package:haru/common/const_values.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScheduleNotifier extends ChangeNotifier {
  final Box<Schedule> storeData;
  ScheduleNotifier({required this.storeData});

  List<Schedule> fetchSchedules() {
    return storeData.keys
        .cast<int>()
        .map((key) => storeData.get(key)!)
        .toList();
  }

  List<Schedule> fetchTodaySchedules() {
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

  void addSchedule(Schedule schedule) async {
    await storeData.add(schedule);
    notifyListeners();
  }

  void deleteSchedule(Schedule schedule) async {
    final key =
        storeData.keys.lastWhere((key) => storeData.get(key) == schedule);
    await storeData.delete(key);
    notifyListeners();
  }
}

final scheduleBoxProvider =
    StateProvider<Box<Schedule>>((ref) => Hive.box(scheduleBox));

final scheduleProvider = ChangeNotifierProvider<ScheduleNotifier>(
    (ref) => ScheduleNotifier(storeData: ref.watch(scheduleBoxProvider).state));