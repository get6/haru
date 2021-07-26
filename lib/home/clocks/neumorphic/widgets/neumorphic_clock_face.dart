import 'dart:async';

import 'package:flutter/material.dart';
import 'hands/hour_hand.dart';
import 'hands/minute_hand.dart';
import 'hands/second_hand.dart';
import 'hands/second_hand_circle.dart';
import 'shadows/hour_hand_shadow.dart';
import 'shadows/minute_hand_shadow.dart';
import 'shadows/second_hand_shadow.dart';

class NeumorphicClockFace extends StatefulWidget {
  final double unit;
  const NeumorphicClockFace({Key? key, required this.unit}) : super(key: key);

  @override
  _NeumorphicClockFaceState createState() => _NeumorphicClockFaceState();
}

class _NeumorphicClockFaceState extends State<NeumorphicClockFace> {
  late DateTime now;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    now = DateTime.now();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        now = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        HourHandShadow(unit: widget.unit, now: now),
        MinuteHandShadow(unit: widget.unit, now: now),
        SecondHandShadow(unit: widget.unit, now: now),
        HourHand(unit: widget.unit, now: now),
        MinuteHand(unit: widget.unit, now: now),
        SecondHand(unit: widget.unit, now: now),
        SecondHandCircle(unit: widget.unit, now: now),
      ],
    );
  }
}
