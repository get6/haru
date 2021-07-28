import 'package:flutter/material.dart';
import 'package:haru/home/clocks/neumorphic/widgets/shadows/inner_shadows.dart';

import 'package:haru/models/schedule/schedule_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'clock_schedule_painter.dart';
import 'clock_ticks.dart';
import 'shadows/outer_shadows.dart';

class NeumorphicClockBody extends ConsumerWidget {
  final double unit;
  const NeumorphicClockBody({Key? key, required this.unit}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final schedules = watch(scheduleProvider).fetchHalfDaySchedules();
    return Stack(
      children: [
        OuterShadows(unit: unit),
        InnerShadows(unit: unit),
        for (final schedule in schedules)
          CustomPaint(
            painter: ClockSchedulePainter(unit: unit, schedule: schedule),
            child: Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
            ),
          ),
        ClockTicks(unit: unit),
      ],
    );
  }
}
