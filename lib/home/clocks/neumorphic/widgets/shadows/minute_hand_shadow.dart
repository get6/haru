import 'package:flutter/material.dart';
import 'package:haru/home/clocks/neumorphic/widgets/hands/animated_container_hand.dart';

class MinuteHandShadow extends StatelessWidget {
  final double unit;
  final DateTime now;
  const MinuteHandShadow({
    Key? key,
    required this.unit,
    required this.now,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(unit / 3, unit / 3),
      child: Padding(
        padding: EdgeInsets.all(2 * unit),
        child: AnimatedContainerHand(
          now: now.minute,
          size: .5,
          child: Transform.translate(
            offset: Offset(.0, -8 * unit),
            child: Container(
              width: unit / 2,
              height: unit * 15,
              decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
                BoxShadow(color: Colors.grey[500]!, blurRadius: unit)
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
