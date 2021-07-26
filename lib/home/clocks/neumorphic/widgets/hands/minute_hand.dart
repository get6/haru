import 'package:flutter/material.dart';
import 'animated_container_hand.dart';

class MinuteHand extends StatelessWidget {
  final double unit;
  final DateTime now;

  const MinuteHand({
    Key? key,
    required this.unit,
    required this.now,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2 * unit),
      child: AnimatedContainerHand(
        now: now.minute,
        size: .5,
        child: Transform.translate(
          offset: Offset(0, -7 * unit),
          child: Container(
            width: unit / 2,
            height: unit * 13,
            decoration: BoxDecoration(
              color: Colors.grey[800],
            ),
          ),
        ),
      ),
    );
  }
}
