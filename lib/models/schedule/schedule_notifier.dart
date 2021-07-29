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
          return schedule!.startTime.isAfter(startTime);
        })
        .map((key) => storeData.get(key)!)
        .toList();
  }

  List<Schedule> fetchHalfDaySchedules() {
    final List<Schedule> schedules = fetchTodaySchedules();
    final currentHour = DateTime.now().hour;
    return schedules.where((schedule) {
      if (currentHour < 12) {
        // AM, 일정 시작시간이 12시 이전이면 표시
        return 12 > schedule.startTime.hour;
      } else {
        // PM, 일정 시작시간이 12시 이후이거나 일정 종료시간이 12시 이후만 표시
        return 12 >= schedule.startTime.hour || 12 <= schedule.endTime.hour;
      }
    }).toList();
  }

  void add(Schedule schedule) async {
    await storeData.add(schedule);
    notifyListeners();
  }

  void delete(Schedule schedule) async {
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
