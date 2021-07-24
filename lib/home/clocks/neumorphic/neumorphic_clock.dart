import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:haru/home/clocks/neumorphic/animated_icon.dart';
import 'package:haru/home/clocks/neumorphic/clock_ticks.dart';
import 'package:haru/home/clocks/neumorphic/hands/hour_hand.dart';
import 'package:haru/home/clocks/neumorphic/hands/minute_hand.dart';
import 'package:haru/home/clocks/neumorphic/hands/second_hand.dart';
import 'package:haru/home/clocks/neumorphic/hands/second_hand_circle.dart';
import 'package:haru/home/clocks/neumorphic/shadows/hour_hand_shadow.dart';
import 'package:haru/home/clocks/neumorphic/shadows/inner_shadows.dart';
import 'package:haru/home/clocks/neumorphic/shadows/minute_hand_shadow.dart';
import 'package:haru/home/clocks/neumorphic/shadows/outer_shadows.dart';
import 'package:haru/home/clocks/neumorphic/shadows/second_hand_shadow.dart';
import 'package:intl/intl.dart';
import 'package:vector_math/vector_math_64.dart' show radians;

/// Total distance traveled by a second or a minute hand, each second or minute,
/// respectively.
final radiansPerTick = radians(360 / 60);

/// Total distance traveled by an hour hand, each hour, in radians.
final radiansPerHour = radians(360 / 12);

class NeumorphicClock extends StatefulWidget {
  NeumorphicClock({Key? key}) : super(key: key);

  @override
  _NeumorphicClockState createState() => _NeumorphicClockState();
}

class _NeumorphicClockState extends State<NeumorphicClock> {
  DateTime now = DateTime.now();
  late Timer timer;

  @override
  void initState() {
    super.initState();
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
    final time = DateFormat.Hms().format(DateTime.now());
    return Center(
      child: AspectRatio(
        aspectRatio: 4 / 3,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).unselectedWidgetColor,
            ),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final unit = constraints.biggest.width / 40;
              return Semantics.fromProperties(
                properties: SemanticsProperties(
                  label: 'Analog clock with time',
                  value: time,
                ),
                child: Container(
                  padding: EdgeInsets.all(2 * unit),
                  child: Stack(
                    children: [
                      OuterShadows(unit: unit),
                      AnimatedClockIcon(unit: unit, icon: Icons.cloud),
                      InnerShadows(unit: unit),
                      ClockTicks(unit: unit),
                      HourHandShadow(unit: unit, now: now),
                      MinuteHandShadow(unit: unit, now: now),
                      SecondHandShadow(unit: unit, now: now),
                      HourHand(unit: unit, now: now),
                      MinuteHand(unit: unit, now: now),
                      SecondHand(unit: unit, now: now),
                      SecondHandCircle(unit: unit, now: now),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
