import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:haru/home/clocks/neumorphic/hands/container_hand.dart';
import 'package:haru/home/clocks/neumorphic/neumorphic_clock.dart';

class HourHand extends StatelessWidget {
  final double unit;
  final DateTime now;
  const HourHand({
    Key? key,
    required this.unit,
    required this.now,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2 * unit),
      child: ContainerHand(
        color: Colors.transparent,
        size: .5,
        angleRadians:
            now.hour * radiansPerHour + (now.minute / 60) * radiansPerHour,
        child: Transform.translate(
          offset: Offset(.0, -3 * unit),
          child: Semantics.fromProperties(
            properties: SemanticsProperties(
                value: '$now.hour',
                label: 'Hour hand of the clock at position $now.hour hrs.'),
            child: Container(
              width: 1.5 * unit,
              height: 7 * unit,
              decoration: BoxDecoration(
                color: Colors.grey[800],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
