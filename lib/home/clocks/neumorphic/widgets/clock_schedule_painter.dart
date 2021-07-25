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
      ..style = PaintingStyle.fill;

    final offset = Offset(-7 * unit, -3 * unit);
    final double startHour = schedule.startTime.hour + .0;
    final double endHour = schedule.endTime.hour + .0;
    final radius = unit * 10;

    canvas.drawArc(
      Rect.fromCircle(center: offset, radius: radius),
      (endHour - 1),
      ((endHour - startHour) * 2 * pi) / 12,
      true,
      paint,
    );
    canvas.save();
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
