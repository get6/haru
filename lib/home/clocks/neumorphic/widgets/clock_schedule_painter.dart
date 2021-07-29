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

    // 12시가 지났는데 일정 시작시간이 12시 전이면 12시로 수정
    final double sHourAngle =
        12 <= DateTime.now().hour && 12 > schedule.startTime.hour
            ? fixedHourAngle(schedule.startTime)
            : hourAngle(schedule.startTime);
    // 12시가 지나지않고 일정 종료시간이 12시 이후이면 12시로 수정
    final double eHourAngle =
        12 > DateTime.now().hour && 12 <= schedule.endTime.hour
            ? fixedHourAngle(schedule.endTime)
            : hourAngle(schedule.endTime);

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

  double getAngle(int hour, int minute) {
    return (hour * 30) + (.5 * minute) - 90;
  }

  double hourAngle(DateTime dateTime) {
    return getAngle(dateTime.hour, dateTime.minute);
  }

  /// 아날로그 시계에는 12시간을 기준으로 AM, PM의 12시간만 보여준다.
  double fixedHourAngle(DateTime dateTime) {
    return getAngle(12, 0);
  }
}
