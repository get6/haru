import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class AnalogClockPainter extends CustomPainter {
  final DateTime _dateTime;
  final double? _borderWidth;

  AnalogClockPainter(this._dateTime, {double? borderWidth})
      : _borderWidth = borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = min(size.width, size.height) / 2;
    final borderWidth = _borderWidth ?? radius / 20.0;

    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(
      Offset.zero,
      radius,
      Paint()
        ..style = PaintingStyle.fill
        ..color = Colors.white,
    );

    // border style
    if (borderWidth > 0) {
      final Paint borderPaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth
        ..isAntiAlias = true;
      canvas.drawCircle(Offset.zero, radius - borderWidth / 2, borderPaint);
    }

    const double L = 150;
    const double S = 6;
    _paintHourHand(canvas, L / 2.0, S);
    _paintMinuteHand(canvas, L / 1.4, S / 1.4);
    _paintSecondHand(canvas, L / 1.2, S / 3);

    // drawing center point
    final Paint centerPointPaint = Paint()
      ..strokeWidth = ((radius - borderWidth) / 10)
      ..strokeCap = StrokeCap.round
      ..color = Colors.black;
    canvas.drawPoints(PointMode.points, [Offset.zero], centerPointPaint);
  }

  // drawing hour hand
  void _paintHourHand(Canvas canvas, double radius, double stokeWidth) {
    final double angle = _dateTime.hour % 12 + _dateTime.minute / 60 - 3;
    final Offset handOffset = Offset(cos(getRadians(angle * 30)) * radius,
        sin(getRadians(angle * 30)) * radius);
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = stokeWidth;
    canvas.drawLine(Offset.zero, handOffset, hourHandPaint);
  }

  // drawing hour hand
  void _paintMinuteHand(Canvas canvas, double radius, double stokeWidth) {
    final double angle = _dateTime.minute - 15;
    final Offset handOffset = Offset(cos(getRadians(angle * 6)) * radius,
        sin(getRadians(angle * 6)) * radius);
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = stokeWidth;
    canvas.drawLine(Offset.zero, handOffset, hourHandPaint);
  }

  // drawing hour hand
  void _paintSecondHand(Canvas canvas, double radius, double stokeWidth) {
    final double angle = _dateTime.second - 15;
    final Offset handOffset = Offset(cos(getRadians(angle * 6)) * radius,
        sin(getRadians(angle * 6)) * radius);
    final hourHandPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = stokeWidth;
    canvas.drawLine(Offset.zero, handOffset, hourHandPaint);
  }

  @override
  bool shouldRepaint(covariant AnalogClockPainter oldDelegate) {
    return _dateTime != oldDelegate._dateTime ||
        _borderWidth != oldDelegate._borderWidth;
  }

  static double getRadians(double angle) {
    return angle * pi / 180;
  }
}
