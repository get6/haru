import 'dart:math';

import 'package:flutter/material.dart';
import 'package:haru/models/schedule/schedule.dart';

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
      ..strokeWidth = 5;

    final int startHour = schedule.startTime.hour;
    final int startMinute = schedule.startTime.minute;
    final int endHour = schedule.endTime.hour;
    final int endMinute = schedule.endTime.minute;

    final double sHourAngle =
        ((startHour * 30) + (.5 * startMinute) - 90).abs();
    final double eHourAngle = ((endHour * 30) + (.5 * endMinute) - 90).abs();

    final offset = size.center(Offset.zero);
    // final radius = offset.dx / 1.5;
    final radius = unit * 10;
    final Rect rect = Rect.fromCircle(center: offset, radius: radius);
    final double startAngle = (sHourAngle * pi) / 180;
    final double sweepAngle = ((eHourAngle - sHourAngle) * pi) / 180;

    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // return oldDelegate != this;
    return false;
  }
}
