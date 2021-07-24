import 'package:flutter/material.dart';
import 'package:haru/home/clocks/neumorphic/hands/animated_container_hand.dart';

class SecondHandCircle extends StatelessWidget {
  final double unit;
  final DateTime now;

  const SecondHandCircle({
    Key? key,
    required this.unit,
    required this.now,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainerHand(
      now: now.second,
      size: .6,
      child: Transform.translate(
        offset: Offset.zero,
        child: Container(
          width: 1.7 * unit,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.red[800],
          ),
        ),
      ),
    );
  }
}
