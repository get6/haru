import 'package:flutter/material.dart';
import 'package:haru/models/schedule/schedule.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

import '../neumorphic_clock.dart';

class ClockSchedulePainter extends CustomPainter {
  final double unit;
  final Schedule schedule;

  ClockSchedulePainter({
    required this.unit,
    required this.schedule,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(schedule.color)
      ..style = PaintingStyle.stroke
      ..strokeWidth = hourWidth * unit;

    final double sHourAngle = fixedHourAngle(schedule.startTime);
    final double eHourAngle = fixedHourAngle(schedule.endTime);

    final Rect rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: unit * 9.5,
    );
    final double startAngle = radians(sHourAngle);
    final double sweepAngle = radians(eHourAngle - sHourAngle);

    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

  double fixedHourAngle(DateTime dateTime) {
    final hour = fixedHour(dateTime.hour);
    final minute = dateTime.minute;
    return (hour * 30) + (.5 * minute) - 90;
  }

  /// 12시간을 기준으로 AM, PM 전 후는 보여주지 않는다.
  int fixedHour(int hour) {
    final currentHour = DateTime.now().hour;
    if (12 <= currentHour) {
      // 12시를 넘긴 경우 0시부터 11시59분까지 끝나는 일정은 표현하지 않음
      if (hour < 12) return 12;
    }
    return hour;
  }
}
