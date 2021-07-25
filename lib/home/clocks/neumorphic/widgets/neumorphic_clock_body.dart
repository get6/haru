import 'package:flutter/material.dart';
import 'package:haru/models/schedule/schedule_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'clock_schedule.dart';
import 'clock_ticks.dart';
import 'shadows/inner_shadows.dart';
import 'shadows/outer_shadows.dart';

class NeumorphicClockBody extends ConsumerWidget {
  final double unit;
  const NeumorphicClockBody({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final schedules = watch(scheduleProvider).fetchTodaySchedules();
    return Stack(
      children: [
        OuterShadows(unit: unit),
        for (final schedule in schedules)
          ClockSchedule(unit: unit, schedule: schedule),
        InnerShadows(unit: unit),
        ClockTicks(unit: unit),
      ],
    );
  }
}
