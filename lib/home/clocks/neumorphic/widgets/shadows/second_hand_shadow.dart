import 'package:flutter/material.dart';
import 'package:haru/common/color/custom_color.dart';
import 'package:haru/home/clocks/neumorphic/widgets/hands/animated_container_hand.dart';

class SecondHandShadow extends StatelessWidget {
  final double unit;
  final DateTime now;
  const SecondHandShadow({
    Key? key,
    required this.unit,
    required this.now,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(unit / 2, unit / 2),
      child: AnimatedContainerHand(
        now: now.second,
        size: .5,
        child: Transform.translate(
          offset: Offset(unit / 4, unit * -3),
          child: Container(
            width: unit / 2,
            height: double.infinity,
            decoration: BoxDecoration(color: Colors.transparent, boxShadow: [
              BoxShadow(
                  color: neumorphicTheme[neumorphicColor.canvas]!,
                  blurRadius: unit),
            ]),
          ),
        ),
      ),
    );
  }
}
