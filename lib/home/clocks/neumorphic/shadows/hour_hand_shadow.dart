import 'package:flutter/material.dart';
import 'package:haru/home/clocks/neumorphic/hands/container_hand.dart';
import 'package:haru/home/clocks/neumorphic/neumorphic_clock.dart';

class HourHandShadow extends StatelessWidget {
  final double unit;
  final DateTime now;
  const HourHandShadow({
    Key? key,
    required this.unit,
    required this.now,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(unit / 4, unit / 5),
      child: Padding(
        padding: EdgeInsets.all(2 * unit),
        child: ContainerHand(
          color: Colors.transparent,
          size: .5,
          angleRadians:
              now.hour * radiansPerHour + (now.minute / 60) * radiansPerHour,
          child: Transform.translate(
            offset: Offset(.0, -3 * unit),
            child: Container(
              width: 1.5 * unit,
              height: 7 * unit,
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(color: Colors.grey[500]!, blurRadius: unit),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
