import 'package:flutter/material.dart';
import 'package:haru/home/clocks/neumorphic/widgets/clock_schedule_painter.dart';
import 'package:haru/models/schedule/schedule.dart';

class ClockSchedule extends StatelessWidget {
  const ClockSchedule({
    Key? key,
    required this.unit,
    required this.schedule,
  }) : super(key: key);

  final double unit;
  final Schedule schedule;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(1.5 * unit),
      child: Center(
        child: ClipOval(
          child: AspectRatio(
            aspectRatio: 1,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Transform.translate(
                offset: Offset(7 * unit, 3 * unit),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(seconds: 2),
                    switchInCurve: Curves.easeInOut,
                    switchOutCurve: Curves.easeInOut,
                    transitionBuilder: (child, anim) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1, 0),
                          end: Offset.zero,
                        ).animate(anim),
                        child: FadeTransition(
                          opacity: anim,
                          child: child,
                        ),
                      );
                    },
                    child: CustomPaint(
                      painter: ClockSchedulePainter(
                        unit: unit,
                        schedule: schedule,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      // child: CustomPaint(
      //   painter: ClockSchedulePainter(
      //       unit: unit, schedule: schedule, constraints: constraints),
      // ),
    );
  }
}
