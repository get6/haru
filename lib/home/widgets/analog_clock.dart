import 'dart:async';

import 'package:flutter/material.dart';

import 'analog_clock_painter.dart';

class AnalogClock extends StatefulWidget {
  final DateTime? dateTime;
  final double? borderWidth;
  final double width;
  final double height;
  final BoxDecoration decoration;

  AnalogClock({
    Key? key,
    this.dateTime,
    this.borderWidth,
    this.width = double.infinity,
    this.height = double.infinity,
    this.decoration = const BoxDecoration(),
  }) : super(key: key);

  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  late Timer _timer;
  late DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    _dateTime = widget.dateTime ?? DateTime.now();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _dateTime = _dateTime.add(const Duration(seconds: 1));
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: widget.decoration,
      child: CustomPaint(
        painter: AnalogClockPainter(
          _dateTime,
          borderWidth: widget.borderWidth,
        ),
      ),
    );
  }
}
