import 'package:flutter/material.dart';

import '../../neumorphic_clock.dart';
import 'container_hand.dart';

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
    // TODO 초가 바뀔때마다 계산해서 시, 분 각도 계산
    return now == 0
        ? TweenAnimationBuilder<double>(
            key: const ValueKey('special_case_when_overflowing'),
            tween: Tween(begin: value(now - 1), end: value(now)),
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            builder: (context, value, child) => ContainerHand(
              color: Colors.transparent,
              size: size,
              angleRadians: value,
              child: child,
            ),
            child: child,
          )
        : TweenAnimationBuilder<double>(
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
