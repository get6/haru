import 'package:flutter/material.dart';
import 'package:haru/home/clocks/neumorphic/hands/container_hand.dart';

import '../neumorphic_clock.dart';

class AnimatedContainerHand extends StatelessWidget {
  final int now;
  final double size;
  final Widget child;
  const AnimatedContainerHand({
    Key? key,
    required this.now,
    required this.size,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (now == 0) {
      return TweenAnimationBuilder<double>(
        key: const ValueKey('special_case_when_overflowing'),
        tween: Tween(begin: value(now - 1), end: value(now)),
        duration: const Duration(microseconds: 300),
        curve: Curves.easeInQuint,
        builder: (context, value, child) => ContainerHand(
          color: Colors.transparent,
          size: size,
          angleRadians: value,
          child: child,
        ),
        child: child,
      );
    }
    return TweenAnimationBuilder<double>(
      key: const ValueKey('normal_case'),
      tween: Tween(begin: value(now - 1), end: value(now)),
      duration: const Duration(milliseconds: 300),
      builder: (context, value, child) => ContainerHand(
        color: Colors.transparent,
        size: size,
        angleRadians: value,
        child: child,
      ),
      child: child,
    );
  }

  double value(int second) {
    return second * radiansPerTick;
  }
}
