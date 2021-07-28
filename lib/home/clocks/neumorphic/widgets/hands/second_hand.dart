import 'package:flutter/material.dart';
import 'animated_container_hand.dart';

class SecondHand extends StatelessWidget {
  final double unit;
  final DateTime now;
  const SecondHand({
    Key? key,
    required this.unit,
    required this.now,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainerHand(
      now: now.second,
      size: .53,
      child: Transform.translate(
        offset: Offset(.0, -5 * unit),
        child: Container(
          width: unit / 2,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[400],
          ),
        ),
      ),
    );
  }
}
