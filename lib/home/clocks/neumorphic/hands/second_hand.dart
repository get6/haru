import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:haru/home/clocks/neumorphic/hands/animated_container_hand.dart';

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
      size: .5,
      child: Transform.translate(
        offset: Offset(.0, -4 * unit),
        child: Semantics.fromProperties(
          properties: SemanticsProperties(
            value: '${now.second}',
            label: 'Seconds hand of the clock at position ${now.second} sec.',
          ),
          child: Container(
            width: unit / 2,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.red[800],
            ),
          ),
        ),
      ),
    );
  }
}
