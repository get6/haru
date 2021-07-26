import 'package:flutter/material.dart';
import 'package:haru/home/clocks/neumorphic/neumorphic_clock.dart';
import 'container_hand.dart';

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
          offset: Offset(.0, -6 * unit),
          child: Container(
            width: 1.2 * unit,
            height: 12 * unit,
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
          ),
        ),
      ),
    );
  }
}
